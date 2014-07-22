class MetricYoutubesController < ApplicationController
  before_action :set_metric_youtube, only: [:show, :edit, :update, :destroy]

  # GET /metric_youtubes
  # GET /metric_youtubes.json
  def index
    @metric_youtubes = MetricYoutube.all
  end

  # GET /metric_youtubes/1
  # GET /metric_youtubes/1.json
  def show
  end

  # GET /metric_youtubes/new
  def new
    @metric_youtube = MetricYoutube.new
  end

  # GET /metric_youtubes/1/edit
  def edit
  end

  # POST /metric_youtubes
  # POST /metric_youtubes.json
  def create
    @metric_youtube = MetricYoutube.new(metric_youtube_params)

    respond_to do |format|
      if @metric_youtube.save
        format.html { redirect_to @metric_youtube, notice: 'Metric youtube was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metric_youtube }
      else
        format.html { render action: 'new' }
        format.json { render json: @metric_youtube.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metric_youtubes/1
  # PATCH/PUT /metric_youtubes/1.json
  def update
    respond_to do |format|
      if @metric_youtube.update(metric_youtube_params)
        format.html { redirect_to @metric_youtube, notice: 'Metric youtube was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metric_youtube.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_youtubes/1
  # DELETE /metric_youtubes/1.json
  def destroy
    @metric_youtube.destroy
    respond_to do |format|
      format.html { redirect_to metric_youtubes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_youtube
      @metric_youtube = MetricYoutube.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_youtube_params
      params.require(:metric_youtube).permit(:region, :location, :rncname, :mobile_code, :imei, :imsi, :script_name, :attempt, :success, :quality, :youtube_succ_rate, :youtube_qual_rate, :youtube_rate)
    end
end
