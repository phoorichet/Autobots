class RawHttpsController < ApplicationController
  before_action :set_raw_http, only: [:show]

  # GET /raw_https
  # GET /raw_https.json
  def index
    page = params[:page] || 1
    @raw_https = RawHttp.page(page)
  end

  # GET /raw_https/1
  # GET /raw_https/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_http
      @raw_http = RawHttp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_http_params
      params.require(:raw_http).permit(:connecting_time_1, :time_to_first_byte_1, :result_1, :result_detail_1, :imei, :imsi, :script_name, :service, :serviceinfo, :agv_rssi, :avg_rxlev, :avg_ecio, :cell_id, :lac, :start_time, :stop_time, :duration_time, :data_download_transfer, :max_download, :max_download_overall, :min_download, :throughput_download_ip, :throughput_download_app, :throughput_download_rlc, :result, :lat, :lon, :apn)
    end
end
