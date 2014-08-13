module Api
  module V1
    class SpeedtestsController < ApplicationController
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
        stack       = params[:stack]
        sgsn        = params[:sgsn]


        # Completely hack on this logic
        # TODO
        if (stack == 'GGSN')
          respond_with MetricSpeedtest
                              .select("date_time, apn as group, avg(#{metric_attr}) as value")
                              .region(region)
                              .site(site)
                              .apn(apn)
                              .sgsn(sgsn)
                              .start(start)
                              .stop(stop)
                              .group(:date_time, :apn)
                              .asc_date_time

        elsif (stack == 'RNC')
          respond_with MetricSpeedtest
                              .select("date_time, rncname as group, avg(#{metric_attr}) as value")
                              .region(region)
                              .site(site)
                              .apn(apn)
                              .sgsn(sgsn)
                              .start(start)
                              .stop(stop)
                              .group(:date_time, :rncname)
                              .asc_date_time

        else                  
          respond_with MetricSpeedtest
                              .select("date_time, avg(#{metric_attr}) as value")
                              .region(region)
                              .site(site)
                              .apn(apn)
                              .sgsn(sgsn)
                              .start(start)
                              .stop(stop)
                              .group(:date_time)
                              .asc_date_time
        end

      end



    end # class

  end # V1
end # Api
