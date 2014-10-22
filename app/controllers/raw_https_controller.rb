class RawHttpsController < ApplicationController
  before_action :set_raw_http, only: [:show, :edit, :update, :destroy]

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

  # GET /raw_https/new
  def new
    @raw_http = RawHttp.new
  end

  # GET /raw_https/1/edit
  def edit
  end

  # POST /raw_https
  # POST /raw_https.json
  def create
    @raw_http = RawHttp.new(raw_http_params)

    respond_to do |format|
      if @raw_http.save
        format.html { redirect_to @raw_http, notice: 'Raw http was successfully created.' }
        format.json { render action: 'show', status: :created, location: @raw_http }
      else
        format.html { render action: 'new' }
        format.json { render json: @raw_http.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_https/1
  # PATCH/PUT /raw_https/1.json
  def update
    respond_to do |format|
      if @raw_http.update(raw_http_params)
        format.html { redirect_to @raw_http, notice: 'Raw http was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @raw_http.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_https/1
  # DELETE /raw_https/1.json
  def destroy
    @raw_http.destroy
    respond_to do |format|
      format.html { redirect_to raw_https_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_http
      @raw_http = RawHttp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_http_params
      params.require(:raw_http).permit(:connecting_time_1, :time_to_first_byte_1, :result_1, :result_detail_1, :imei, :imsi, :script_name, :service, :service_info, :agv_rssi, :avg_rxlev, :avg_ecio, :cell_id, :lac, :start_time, :stop_time, :duration_time, :data_download_transfer, :max_download, :max_download_overall, :min_download, :throughput_download_ip, :throughput_download_app, :throughput_download_rlc, :result, :lat, :lon, :apn)
    end
end
