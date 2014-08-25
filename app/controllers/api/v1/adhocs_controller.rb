module Api
  module V1
    class AdhocsController < ApplicationController
      include ApiHelper
      respond_to :json

      # Get data and configurations for visualization
      def heatmap
        
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

        avg_rtt_succ_rate = "avg_rtt_succ_rate"
        youtube_succ_rate = "youtube_succ_rate"
        speedtest_dl_2m_rate = "speedtest_dl_2m_rate"


        results = []
        # Completely hack on this logic
        # TODO
        if (stack == 'GGSN')
          MetricHttp.facebook
            .select("date_time, apn as group, avg(#{metric_attr}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time, :apn)
            .asc_date_time
            .each do | d|
              t = d.attributes
              t["service"] = "facebook"
              results << d
            end

          MetricPing
            .select("date_time, apn as group, avg(#{avg_rtt_succ_rate}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time, :apn)
            .asc_date_time
            .each do | d|
              results << d
            end

          MetricYoutube
            .select("date_time, apn as group, avg(#{youtube_succ_rate}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time, :apn)
            .asc_date_time
            .each do | d|
              results << d
            end

          MetricSpeedtest
            .select("date_time, apn as group, avg(#{speedtest_dl_2m_rate}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time, :apn)
            .asc_date_time
            .each do | d|
              results << d
            end



        elsif (stack == 'RNC')
          MetricHttp
            .select("date_time, rncname as group, avg(#{metric_attr}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time, :rncname)
            .asc_date_time
            .each do | d|
              results << d
            end



        else                  
          MetricHttp
            .select("date_time, avg(#{metric_attr}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time)
            .asc_date_time
            .each do | d|
              t = d.attributes
              t["service"] = "HTTP"
              results << t
            end

          # MetricHttp.twitter
          #   .select("date_time, avg(#{metric_attr}) as value")
          #   .region(region)
          #   .site(site)
          #   .apn(apn)
          #   .sgsn(sgsn)
          #   .start(start)
          #   .stop(stop)
          #   .group(:date_time)
          #   .asc_date_time
          #   .each do | d|
          #     t = d.attributes
          #     t["service"] = "twitter"
          #     results << t
          #   end

          # MetricHttp.instagram
          #   .select("date_time, avg(#{metric_attr}) as value")
          #   .region(region)
          #   .site(site)
          #   .apn(apn)
          #   .sgsn(sgsn)
          #   .start(start)
          #   .stop(stop)
          #   .group(:date_time)
          #   .asc_date_time
          #   .each do | d|
          #     t = d.attributes
          #     t["service"] = "instagram"
          #     results << t
          #   end

          MetricPing
            .select("date_time, avg(#{avg_rtt_succ_rate}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time)
            .asc_date_time
            .each do | d|
              t = d.attributes
              t["service"] = "Ping"
              results << t
            end

          MetricYoutube
            .select("date_time, avg(#{youtube_succ_rate}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time)
            .asc_date_time
            .each do | d|
              t = d.attributes
              t["service"] = "Youtube"
              results << t
            end

          MetricSpeedtest
            .select("date_time, avg(#{speedtest_dl_2m_rate}) as value")
            .region(region)
            .site(site)
            .apn(apn)
            .sgsn(sgsn)
            .start(start)
            .stop(stop)
            .group(:date_time)
            .asc_date_time
            .each do | d|
              t = d.attributes
              t["service"] = "Speedtest"
              results << t
            end

        end

        respond_with results

      end #def heatmap

      



    end # class

  end # V1
end # Api
