class SelectfsController < ApplicationController
  before_action :set_metric
  before_action :set_selectf, only: [:show, :edit, :update, :destroy]

  # GET /selectfs
  # GET /selectfs.json
  def index
    @selectfs = @metric.selectfs.all
  end

  # GET /selectfs/1
  # GET /selectfs/1.json
  def show
  end

  # GET /selectfs/new
  def new
    @selectf = @metric.selectfs.new
  end

  # GET /selectfs/1/edit
  def edit
  end

  # POST /selectfs
  # POST /selectfs.json
  def create
    @selectf = @metric.selectfs.new(selectf_params)

    respond_to do |format|
      if @selectf.save
        format.html { redirect_to [@selectf.metric, @selectf], notice: 'Selectf was successfully created.' }
        format.json { render action: 'show', status: :created, location: @selectf }
      else
        format.html { render action: 'new' }
        format.json { render json: @selectf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /selectfs/1
  # PATCH/PUT /selectfs/1.json
  def update
    respond_to do |format|
      if @selectf.update(selectf_params)
        format.html { redirect_to [@selectf.metric, @selectf ], notice: 'Selectf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @selectf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selectfs/1
  # DELETE /selectfs/1.json
  def destroy
    @selectf.destroy
    respond_to do |format|
      format.html { redirect_to [@metric.service, @metric] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selectf
      @selectf = Selectf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def selectf_params
      params.require(:selectf).permit(:field, :selected, :metric_id)
    end

    # Get metric
    def set_metric
      @metric = Metric.find(params[:metric_id])
    end
end
