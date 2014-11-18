class RawPingsController < ApplicationController
  before_action :set_raw_ping, only: [:show]

  # GET /raw_pings
  # GET /raw_pings.json
  def index
    page = params[:page] || 1
    @raw_pings = RawPing.page(page)
  end

  # GET /raw_pings/1
  # GET /raw_pings/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_ping
      @raw_ping = RawPing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_ping_params
      params.require(:raw_ping).permit(:imei, :imsi, :technology, :datetime, :packet_sent, :packet_received, :packet_lost, :rtt_min, :rtt_max, :rtt_mdev, :apn, :apn_mcc, :apn_mnc, :ip, :lac, :cell_id, :script_name, :packet_size)
    end
end
