class MetricPingsController < ApplicationController
  before_action :set_metric_ping, only: [:show, :edit, :update, :destroy]

  # GET /metric_pings
  # GET /metric_pings.json
  def index
    page = params[:page] || 1
    @metric_pings = MetricPing.page(page)
  end

  # GET /metric_pings/1
  # GET /metric_pings/1.json
  def show
  end

  # GET /metric_pings/new
  def new
    @metric_ping = MetricPing.new
  end

  # GET /metric_pings/1/edit
  def edit
  end

  # POST /metric_pings
  # POST /metric_pings.json
  def create
    @metric_ping = MetricPing.new(metric_ping_params)

    respond_to do |format|
      if @metric_ping.save
        format.html { redirect_to @metric_ping, notice: 'Metric ping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metric_ping }
      else
        format.html { render action: 'new' }
        format.json { render json: @metric_ping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metric_pings/1
  # PATCH/PUT /metric_pings/1.json
  def update
    respond_to do |format|
      if @metric_ping.update(metric_ping_params)
        format.html { redirect_to @metric_ping, notice: 'Metric ping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metric_ping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_pings/1
  # DELETE /metric_pings/1.json
  def destroy
    @metric_ping.destroy
    respond_to do |format|
      format.html { redirect_to metric_pings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_ping
      @metric_ping = MetricPing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_ping_params
      params.require(:metric_ping).permit(:region, :location, :rncname, :mobile_code, :imei, :imsi, :target_ip, :attempt, :percent_loss, :avg_packet_loss_rate, :avg_rtt_succ_rate, :date_time, :created_at)
    end
end
