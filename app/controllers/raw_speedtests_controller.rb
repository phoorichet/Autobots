class RawSpeedtestsController < ApplicationController
  before_action :set_raw_speedtest, only: [:show]

  # GET /raw_speedtests
  # GET /raw_speedtests.json
  def index
    page = params[:page] || 1
    @raw_speedtests = RawSpeedtest.page(page)
  end

  # GET /raw_speedtests/1
  # GET /raw_speedtests/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_speedtest
      @raw_speedtest = RawSpeedtest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_speedtest_params
      params.require(:raw_speedtest).permit(:imei, :imsi, :technology, :datetime, :download, :upload, :latency, :server_id, :server_name, :avg_ecio, :avg_rssi, :mcc, :mcc, :lac, :cell_id, :script_name, :operator, :result, :set_server_id, :set_server_name, :apn)
    end
end
