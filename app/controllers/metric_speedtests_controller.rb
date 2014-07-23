class MetricSpeedtestsController < ApplicationController
  before_action :set_metric_speedtest, only: [:show, :edit, :update, :destroy]

  # GET /metric_speedtests
  # GET /metric_speedtests.json
  def index
    page = params[:page] || 1
    @metric_speedtests = MetricSpeedtest.page(page)
  end

  # GET /metric_speedtests/1
  # GET /metric_speedtests/1.json
  def show
  end

  # GET /metric_speedtests/new
  def new
    @metric_speedtest = MetricSpeedtest.new
  end

  # GET /metric_speedtests/1/edit
  def edit
  end

  # POST /metric_speedtests
  # POST /metric_speedtests.json
  def create
    @metric_speedtest = MetricSpeedtest.new(metric_speedtest_params)

    respond_to do |format|
      if @metric_speedtest.save
        format.html { redirect_to @metric_speedtest, notice: 'Metric speedtest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metric_speedtest }
      else
        format.html { render action: 'new' }
        format.json { render json: @metric_speedtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metric_speedtests/1
  # PATCH/PUT /metric_speedtests/1.json
  def update
    respond_to do |format|
      if @metric_speedtest.update(metric_speedtest_params)
        format.html { redirect_to @metric_speedtest, notice: 'Metric speedtest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metric_speedtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_speedtests/1
  # DELETE /metric_speedtests/1.json
  def destroy
    @metric_speedtest.destroy
    respond_to do |format|
      format.html { redirect_to metric_speedtests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_speedtest
      @metric_speedtest = MetricSpeedtest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_speedtest_params
      params.require(:metric_speedtest).permit(:region, :location, :rncname, :mobile_code, :imei, :imsi, :script_name, :set_server_name, :attempt, :download_1mbps, :speedtest_dl_1m_rate, :download_2mbps, :speedtest_dl_2m_rate, :upload_300kbps, :speedtest_ul_300k_rate, :upload_1mkbps, :speedtest_ul_1m_rate, :latency_300ms, :speedtest_lt_300k_rate, :date_time, :created_at)
    end
end
