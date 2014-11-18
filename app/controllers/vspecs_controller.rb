class VspecsController < ApplicationController
  before_action :set_metric
  before_action :set_vspec, only: [:show, :edit, :update, :destroy]

  # GET /vspecs
  # GET /vspecs.json
  def index
    @vspecs = @metric.vspecs.all
  end

  # GET /vspecs/1
  # GET /vspecs/1.json
  def show
  end

  # GET /vspecs/new
  def new
    @vspec = @metric.vspecs.new
    authorize! :manage, @vspec
  end

  # GET /vspecs/1/edit
  def edit
    authorize! :manage, @vspec
  end

  # POST /vspecs
  # POST /vspecs.json
  def create
    @vspec = @metric.vspecs.new(vspec_params)
    authorize! :manage, @vspec

    respond_to do |format|
      if @vspec.save
        format.html { redirect_to [@vspec.metric, @vspec], notice: 'Vspec was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vspec }
      else
        format.html { render action: 'new' }
        format.json { render json: @vspec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vspecs/1
  # PATCH/PUT /vspecs/1.json
  def update
    authorize! :manage, @vspec

    respond_to do |format|
      if @vspec.update(vspec_params)
        format.html { redirect_to [@vspec.metric, @vspec], notice: 'Vspec was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vspec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vspecs/1
  # DELETE /vspecs/1.json
  def destroy
    authorize! :manage, @vspec
    metric = @vspec.metric
    @vspec.destroy
    respond_to do |format|
      format.html { redirect_to [metric.service, metric] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vspec
      @vspec = Vspec.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vspec_params
      params.require(:vspec).permit(:name, :value, :metric_id)
    end

    # Get metric
    def set_metric
      @metric = Metric.find(params[:metric_id])
    end
end
