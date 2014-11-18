class RawYoutubesController < ApplicationController
  before_action :set_raw_youtube, only: [:show]

  # GET /raw_youtubes
  # GET /raw_youtubes.json
  def index
    page = params[:page] || 1
    @raw_youtubes = RawYoutube.page
  end

  # GET /raw_youtubes/1
  # GET /raw_youtubes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_youtube
      @raw_youtube = RawYoutube.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_youtube_params
      params.require(:raw_youtube).permit(:imei, :imsi, :script_name, :operator, :technology, :avg_rssi, :avg_rxlev, :avg_ecio, :cell_id, :lac, :start_time, :stop_time, :duration_time, :data_download_transfer, :throughput_download_app, :throughput_download_rlc, :result, :result_detail, :youtube_video_duration, :lat, :lon, :apn)
    end
end
