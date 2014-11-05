class MsRncSgsnsController < ApplicationController
  before_action :set_ms_rnc_sgsn, only: [:show, :edit, :update, :destroy]

  # GET /ms_rnc_sgsns
  # GET /ms_rnc_sgsns.json
  def index
    @ms_rnc_sgsns = MsRncSgsn.all
  end

  # GET /ms_rnc_sgsns/1
  # GET /ms_rnc_sgsns/1.json
  def show
  end

  # GET /ms_rnc_sgsns/new
  def new
    @ms_rnc_sgsn = MsRncSgsn.new
  end

  # GET /ms_rnc_sgsns/1/edit
  def edit
  end

  # POST /ms_rnc_sgsns
  # POST /ms_rnc_sgsns.json
  def create
    @ms_rnc_sgsn = MsRncSgsn.new(ms_rnc_sgsn_params)

    respond_to do |format|
      if @ms_rnc_sgsn.save
        format.html { redirect_to @ms_rnc_sgsn, notice: 'Ms rnc sgsn was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ms_rnc_sgsn }
      else
        format.html { render action: 'new' }
        format.json { render json: @ms_rnc_sgsn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ms_rnc_sgsns/1
  # PATCH/PUT /ms_rnc_sgsns/1.json
  def update
    respond_to do |format|
      if @ms_rnc_sgsn.update(ms_rnc_sgsn_params)
        format.html { redirect_to @ms_rnc_sgsn, notice: 'Ms rnc sgsn was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ms_rnc_sgsn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ms_rnc_sgsns/1
  # DELETE /ms_rnc_sgsns/1.json
  def destroy
    @ms_rnc_sgsn.destroy
    respond_to do |format|
      format.html { redirect_to ms_rnc_sgsns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ms_rnc_sgsn
      @ms_rnc_sgsn = MsRncSgsn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ms_rnc_sgsn_params
      params.require(:ms_rnc_sgsn).permit(:rnc_name, :sgsn_name)
    end
end
