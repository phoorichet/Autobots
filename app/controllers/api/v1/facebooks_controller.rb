module Api
  module V1
    class FacebooksController < ApplicationController
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

        results = results.where("serviceinfo = ?",  "FACEBOOK") 

        respond_with results

      end

      # Retrun an array of nodes and links to build force layout
      def force
        if not validate_params(params)
          respond_with msg: "Invalid params", type: "error"
        end

        options = build_options(params)
        vspec   = options[:vspec].symbolize_keys
        puts "==> #{options[:vspec]}"


        data = Node.get_force(options)

        respond_with data
      end

      def metric_by_region
        if not validate_params(params)
          respond_with msg: "Invalid params", type: "error"
        end

        options = build_options(params)
        vspec   = options[:vspec].symbolize_keys
        puts "==> #{options[:vspec]}"

        results = MetricHttp.vtype(vspec[:vtype])
                              .xaxis(vspec[:x])
                              .yaxis(vspec[:y])
                              .aggregate("avg")
                              .stack(vspec[:stack])
                              .run

        # addtional criteria
        results = results.where("#{vspec[:date_time]} >= ?", options[:start]) if options[:start]
        results = results.where("#{vspec[:date_time]} <  ?", options[:stop]) if options[:stop] 
        results = results.where("region =  ?", options[:region]) if options[:region] 

        respond_with results

      end



    end # class

  end # V1
end # Api
