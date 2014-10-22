class RawPingsController < ApplicationController
  before_action :set_raw_ping, only: [:show, :edit, :update, :destroy]

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

  # GET /raw_pings/new
  def new
    @raw_ping = RawPing.new
  end

  # GET /raw_pings/1/edit
  def edit
  end

  # POST /raw_pings
  # POST /raw_pings.json
  def create
    @raw_ping = RawPing.new(raw_ping_params)

    respond_to do |format|
      if @raw_ping.save
        format.html { redirect_to @raw_ping, notice: 'Raw ping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @raw_ping }
      else
        format.html { render action: 'new' }
        format.json { render json: @raw_ping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_pings/1
  # PATCH/PUT /raw_pings/1.json
  def update
    respond_to do |format|
      if @raw_ping.update(raw_ping_params)
        format.html { redirect_to @raw_ping, notice: 'Raw ping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @raw_ping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_pings/1
  # DELETE /raw_pings/1.json
  def destroy
    @raw_ping.destroy
    respond_to do |format|
      format.html { redirect_to raw_pings_url }
      format.json { head :no_content }
    end
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
