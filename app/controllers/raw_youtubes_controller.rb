class RawYoutubesController < ApplicationController
  before_action :set_raw_youtube, only: [:show, :edit, :update, :destroy]

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

  # GET /raw_youtubes/new
  def new
    @raw_youtube = RawYoutube.new
  end

  # GET /raw_youtubes/1/edit
  def edit
  end

  # POST /raw_youtubes
  # POST /raw_youtubes.json
  def create
    @raw_youtube = RawYoutube.new(raw_youtube_params)

    respond_to do |format|
      if @raw_youtube.save
        format.html { redirect_to @raw_youtube, notice: 'Raw youtube was successfully created.' }
        format.json { render action: 'show', status: :created, location: @raw_youtube }
      else
        format.html { render action: 'new' }
        format.json { render json: @raw_youtube.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_youtubes/1
  # PATCH/PUT /raw_youtubes/1.json
  def update
    respond_to do |format|
      if @raw_youtube.update(raw_youtube_params)
        format.html { redirect_to @raw_youtube, notice: 'Raw youtube was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @raw_youtube.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_youtubes/1
  # DELETE /raw_youtubes/1.json
  def destroy
    @raw_youtube.destroy
    respond_to do |format|
      format.html { redirect_to raw_youtubes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_youtube
      @raw_youtube = RawYoutube.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_youtube_params
      params.require(:raw_youtube).permit(:imei, :imsi, :script_name, :operator, :technology, :avg_rssi, :avg_rxlen, :avg_ecio, :cell_id, :lac, :start_time, :stop_time, :duration_time, :data_download_transfer, :throughput_download_app, :throughput_download_rlc, :result, :result_detail, :youtube_video_duration, :lat, :lon, :apn)
    end
end
