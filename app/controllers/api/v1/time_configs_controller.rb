module Api
  module V1
    class TimeConfigsController < ApplicationController
      include ApiHelper
      respond_to :json

      def index
        respond_with TimeConfig.all
      end


    end # class

  end # V1
end # Api
