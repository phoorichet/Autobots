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
        results = results.order("#{vspec[:date_time]} ASC")
        results = results.where("region =  ?", options[:region]) if options[:region] 

        respond_with results

      end

      # Retrun an array of nodes and links to build force layout
      def force
        if not validate_params(params)
          respond_with msg: "Invalid params", type: "error"
        end

        options = build_options(params)
        select_statement = build_select(options)
        group_statement  = build_groups(options)

        data = Node.get_force(options, select_statement, group_statement)

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
