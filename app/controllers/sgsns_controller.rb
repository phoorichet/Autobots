class SgsnsController < ApplicationController
  before_action :set_sgsn, only: [:show, :edit, :update, :destroy]

  # GET /sgsns
  # GET /sgsns.json
  def index
    @sgsns = Sgsn.all
  end

  # GET /sgsns/1
  # GET /sgsns/1.json
  def show
  end

  # GET /sgsns/new
  def new
    @sgsn = Sgsn.new
  end

  # GET /sgsns/1/edit
  def edit
  end

  # POST /sgsns
  # POST /sgsns.json
  def create
    @sgsn = Sgsn.new(sgsn_params)

    respond_to do |format|
      if @sgsn.save
        format.html { redirect_to @sgsn, notice: 'Sgsn was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sgsn }
      else
        format.html { render action: 'new' }
        format.json { render json: @sgsn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sgsns/1
  # PATCH/PUT /sgsns/1.json
  def update
    respond_to do |format|
      if @sgsn.update(sgsn_params)
        format.html { redirect_to @sgsn, notice: 'Sgsn was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sgsn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sgsns/1
  # DELETE /sgsns/1.json
  def destroy
    @sgsn.destroy
    respond_to do |format|
      format.html { redirect_to sgsns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sgsn
      @sgsn = Sgsn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sgsn_params
      params.require(:sgsn).permit(:name)
    end
end
