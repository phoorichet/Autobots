class RawSpeedtestsController < ApplicationController
  before_action :set_raw_speedtest, only: [:show, :edit, :update, :destroy]

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

  # GET /raw_speedtests/new
  def new
    @raw_speedtest = RawSpeedtest.new
  end

  # GET /raw_speedtests/1/edit
  def edit
  end

  # POST /raw_speedtests
  # POST /raw_speedtests.json
  def create
    @raw_speedtest = RawSpeedtest.new(raw_speedtest_params)

    respond_to do |format|
      if @raw_speedtest.save
        format.html { redirect_to @raw_speedtest, notice: 'Raw speedtest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @raw_speedtest }
      else
        format.html { render action: 'new' }
        format.json { render json: @raw_speedtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_speedtests/1
  # PATCH/PUT /raw_speedtests/1.json
  def update
    respond_to do |format|
      if @raw_speedtest.update(raw_speedtest_params)
        format.html { redirect_to @raw_speedtest, notice: 'Raw speedtest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @raw_speedtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_speedtests/1
  # DELETE /raw_speedtests/1.json
  def destroy
    @raw_speedtest.destroy
    respond_to do |format|
      format.html { redirect_to raw_speedtests_url }
      format.json { head :no_content }
    end
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
