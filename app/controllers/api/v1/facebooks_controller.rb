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
        select_statement = build_select(options)
        group_statement  = build_groups(options)

        respond_with MetricHttp.facebook
                              .select(select_statement)
                              .region(options[:region])
                              .site(options[:site])
                              .apn(options[:apn])
                              .sgsn(options[:sgsn])
                              .start(options[:start])
                              .stop(options[:stop])
                              .group(group_statement)
                              .asc_date_time

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

      # def metric_by_region



    end # class

  end # V1
end # Api
