class MetricHttpsController < ApplicationController
  before_action :set_metric_http, only: [:show, :edit, :update, :destroy]

  # GET /metric_https
  # GET /metric_https.json
  def index
    @metric_https = MetricHttp.all
  end

  # GET /metric_https/1
  # GET /metric_https/1.json
  def show
  end

  # GET /metric_https/new
  def new
    @metric_http = MetricHttp.new
  end

  # GET /metric_https/1/edit
  def edit
  end

  # POST /metric_https
  # POST /metric_https.json
  def create
    @metric_http = MetricHttp.new(metric_http_params)

    respond_to do |format|
      if @metric_http.save
        format.html { redirect_to @metric_http, notice: 'Metric http was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metric_http }
      else
        format.html { render action: 'new' }
        format.json { render json: @metric_http.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metric_https/1
  # PATCH/PUT /metric_https/1.json
  def update
    respond_to do |format|
      if @metric_http.update(metric_http_params)
        format.html { redirect_to @metric_http, notice: 'Metric http was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metric_http.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_https/1
  # DELETE /metric_https/1.json
  def destroy
    @metric_http.destroy
    respond_to do |format|
      format.html { redirect_to metric_https_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_http
      @metric_http = MetricHttp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_http_params
      params.require(:metric_http).permit(:region, :location, :rncname, :mobile_code, :imei, :imsi, :script_name, :apn, :serviceinfo, :attempt, :success, :http_succ_rate)
    end
end
