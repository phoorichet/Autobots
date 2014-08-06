module Api
  module V1
    class FacebooksController < ApplicationController
      respond_to :json

      # Get data and configurations for visualization
      def metric
        metric_attr = params[:attr]
        respond_with MetricHttp.facebook.north.where("apn = ?", '3GGSNSUK4N').to_json
      end

    end # class

  end # V1
end # Api
