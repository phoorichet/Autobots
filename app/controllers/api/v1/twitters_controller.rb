module Api
  module V1
    class TwittersController < ApplicationController
      include ApiHelper
      respond_to :json

      # Get data and configurations for visualization
      def metric      
        if not validate_params(params)
          respond_with msg: "Invalid params", type: "error"
        end

        options = build_options(params)
        vspec   = options[:vspec].symbolize_keys
        filters = options[:filters].symbolize_keys
        puts "==> #{options[:vspec]}"
        puts "==> #{filters}"

        results = MetricHttp.vtype(vspec[:vtype])
                              .xaxis(vspec[:x])
                              .yaxis(vspec[:y])
                              .aggregate("avg")
                              .stack(vspec[:stack])
                              .run

        # addtional criteria
        results = results.where("#{vspec[:date_time]} >= ?", options[:start]) if options[:start]
        results = results.where("#{vspec[:date_time]} <  ?", options[:stop]) if options[:stop] 
        results = results.order("#{vspec[:date_time]} ASC")
        results = results.where("region =  ?",  filters[:region]) if filters[:region] 
        results = results.where("sgsn_name =  ?",    filters[:sgsn]) if filters[:sgsn] 
        results = results.where("apn =  ?",     filters[:apn]) if filters[:apn] 
        results = results.where("site = ?",  filters[:site]) if filters[:site] 

        results = results.where("serviceinfo = ?",  "TWITTER") 

        respond_with results

      end

      # Get data and configurations for visualization
      def mapreduce      
        if not validate_params(params)
          respond_with msg: "Invalid params", type: "error"
        end

        metric = Metric.find(params[:id])
        
        options = build_options(params)
        vspec   = metric.vspecs.map{|d| d.attributes }

        filters = options[:filters].symbolize_keys

        time_series_attribute = metric.vspecs.where(name: "time_series_attribute").first
        time_series_attribute = time_series_attribute[:value]

        # Required criteria
        results = RawHttp.twitter
        results = results.select(metric.selectfs.map{|d| d.field})
        results = results.where("#{time_series_attribute} >= ?", options[:start]) if options[:start]
        results = results.where("#{time_series_attribute} <  ?", options[:stop]) if options[:stop] 
        results = results.order("#{time_series_attribute} ASC")

        metric.filters.each do |d|
          operand = d.operand

          if (d.operand_type == 'integer')
            operand = operand.to_i
          elsif (d.operand_type == 'float')
            operand = operand.to_f
          else
            operand = operand.to_s  
          end
              
          results = results.where("#{d.field} #{d.operation} ?", operand)
        end

        # Addtional criteria
        # results = results.where("region =  ?",  filters[:region]) if filters[:region] 
        # results = results.where("sgsn_name =  ?",    filters[:sgsn]) if filters[:sgsn] 
        results = results.where("apn =  ?",     filters[:apn]) if filters[:apn] 
        results = results.where("apn LIKE ?", "%#{filters[:site]}%") if filters[:site] 

        # ---------
        # Hack to make region and sgsn filters work
        region_imeis = nil
        if filters[:region]
          region       = filters[:region]
          region_imeis = MsLocation.select(:imei).region(region).pluck(:imei)
          results = results.where(imei: region_imeis)
        end

        sgsn_imeis = nil
        if filters[:sgsn]
          sgsn = filters[:sgsn]
          rnc_names   = MsRncSgsn.select(:rnc_name).sgsn(sgsn).pluck(:rnc_name)
          sgsn_imeis  = MsLocation.select(:imei).rncs(rnc_names).pluck(:imei)
          results = results.where(imei: sgsn_imeis)
        end
        # end Hack
        # ---------

        # Kinda dangerous to use eval here. Must grant only admin user to 
        # be able to add/change mapf, groupf, and reducef functions
        results = results.map(&eval(metric.mapf))
                        .group_by(&eval(metric.groupf))
                        .map(&lambda{ |d| 
                          return {
                            groups: d[0], 
                            values: d[1].reduce(eval(metric.reducef_init_value), &eval(metric.reducef)) 
                          } 
                        })

        respond_with results

      end

      def mapreduce_join_mslocation
        if not validate_params(params)
          respond_with msg: "Invalid params", type: "error"
        end

        metric = Metric.find(params[:id])
        
        options = build_options(params)
        vspec   = metric.vspecs.map{|d| d.attributes }

        filters = options[:filters].symbolize_keys

        time_series_attribute = metric.vspecs.where(name: "time_series_attribute").first
        time_series_attribute = time_series_attribute[:value]

        select_list = metric.selectfs.map{|d| "#{RawHttp.table_name}.#{d.field}"}
        select_list << "#{MsLocation.table_name}.region"
        select_list << "#{MsLocation.table_name}.rncname"
        
        # Required criteria
        results = RawHttp.twitter
        results = results.select(select_list)
        results = results.where("#{time_series_attribute} >= ?", options[:start]) if options[:start]
        results = results.where("#{time_series_attribute} <  ?", options[:stop]) if options[:stop] 
        results = results.order("#{time_series_attribute} ASC")

        metric.filters.each do |d|
          operand = d.operand

          if (d.operand_type == 'integer')
            operand = operand.to_i
          elsif (d.operand_type == 'float')
            operand = operand.to_f
          else
            operand = operand.to_s  
          end
              
          results = results.where("#{d.field} #{d.operation} ?", operand)
        end

        # Addtional criteria
        # results = results.where("region =  ?",  filters[:region]) if filters[:region] 
        # results = results.where("sgsn_name =  ?",    filters[:sgsn]) if filters[:sgsn] 
        results = results.where("apn =  ?",     filters[:apn]) if filters[:apn] 
        results = results.where("apn LIKE ?", "%#{filters[:site]}%") if filters[:site] 

        # ---------
        # Hack to make region and sgsn filters work
        region_imeis = nil
        if filters[:region]
          region       = filters[:region]
          region_imeis = MsLocation.select(:imei).region(region).pluck(:imei)
          results = results.where(imei: region_imeis)
        end

        sgsn_imeis = nil
        if filters[:sgsn]
          sgsn = filters[:sgsn]
          rnc_names   = MsRncSgsn.select(:rnc_name).sgsn(sgsn).pluck(:rnc_name)
          sgsn_imeis  = MsLocation.select(:imei).rncs(rnc_names).pluck(:imei)
          results = results.where(imei: sgsn_imeis)
        end
        # end Hack
        # ---------

        # Join to get region attributes
        results = results.joins("LEFT JOIN #{MsLocation.table_name} ON #{RawHttp.table_name}.imei = #{MsLocation.table_name}.imei")

        # results.map { |e| puts e.attributes }
        # Kinda dangerous to use eval here. Must grant only admin user to 
        # be able to add/change mapf, groupf, and reducef functions
        results = results.map(&eval(metric.mapf))
                        .group_by(&eval(metric.groupf))
                        .map(&lambda{ |d| 
                          return {
                            groups: d[0], 
                            values: d[1].reduce(eval(metric.reducef_init_value), &eval(metric.reducef)) 
                          } 
                        })

        respond_with results

      end



    end # class

  end # V1
end # Api
