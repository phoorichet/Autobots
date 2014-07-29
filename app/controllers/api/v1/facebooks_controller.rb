module Api
  module V1
    class FacebooksController < ApplicationController
      respond_to :json

      # Get data and configurations for visualization
      def metric
        respond_with MetricHttp.first.to_json
      end

    end # class

  end # V1
end # Api