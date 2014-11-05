class MsLocationsController < ApplicationController
  before_action :set_ms_location, only: [:show, :edit, :update, :destroy]

  # GET /ms_locations
  # GET /ms_locations.json
  def index
    @ms_locations = MsLocation.all
  end

  # GET /ms_locations/1
  # GET /ms_locations/1.json
  def show
  end

  # GET /ms_locations/new
  def new
    @ms_location = MsLocation.new
  end

  # GET /ms_locations/1/edit
  def edit
  end

  # POST /ms_locations
  # POST /ms_locations.json
  def create
    @ms_location = MsLocation.new(ms_location_params)

    respond_to do |format|
      if @ms_location.save
        format.html { redirect_to @ms_location, notice: 'Ms location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ms_location }
      else
        format.html { render action: 'new' }
        format.json { render json: @ms_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ms_locations/1
  # PATCH/PUT /ms_locations/1.json
  def update
    respond_to do |format|
      if @ms_location.update(ms_location_params)
        format.html { redirect_to @ms_location, notice: 'Ms location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ms_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ms_locations/1
  # DELETE /ms_locations/1.json
  def destroy
    @ms_location.destroy
    respond_to do |format|
      format.html { redirect_to ms_locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ms_location
      @ms_location = MsLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ms_location_params
      params.require(:ms_location).permit(:mobile_code, :mini_box, :imei, :serial_no, :mobile_no, :region, :rncname, :building_id, :location)
    end
end
