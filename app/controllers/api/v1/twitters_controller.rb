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
        select_statement = build_select(options)
        group_statement  = build_groups(options)

        respond_with MetricHttp.twitter
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



    end # class

  end # V1
end # Api
