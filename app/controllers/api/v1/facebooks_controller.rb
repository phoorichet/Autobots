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

        metric_attr = params[:attr]
        timeobj     = JSON.parse(params[:time])
        start       = long_to_date(timeobj["from"]["time"])
        stop        = long_to_date(timeobj["to"]["time"])
        region      = params[:region]
        site        = params[:site]
        apn         = params[:apn]
        respond_with MetricHttp.facebook
                              .select("date_time, avg(#{metric_attr}) as #{metric_attr}")
                              .region(region)
                              .site(site)
                              .apn(apn)
                              .start(start)
                              .stop(stop)
                              .group(:date_time)
                              .asc_date_time

      end



    end # class

  end # V1
end # Api
