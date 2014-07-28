class MetricsController < ApplicationController
  before_action :set_service
  before_action :set_metric, only: [:show, :edit, :update, :destroy]

  # GET /metrics
  # GET /metrics.json
  def index
    @metrics = @service.metrics.all
  end

  # GET /metrics/1
  # GET /metrics/1.json
  def show
  end

  # GET /metrics/new
  def new
    @metric = @service.metrics.new
  end

  # GET /metrics/1/edit
  def edit
  end

  # POST /metrics
  # POST /metrics.json
  def create
    @metric = @service.metrics.new(metric_params)

    respond_to do |format|
      if @metric.save
        format.html { redirect_to [@metric.service, @metric], notice: 'Metric was successfully created.' }
        format.json { render action: 'show', status: :created, location: @metric }
      else
        format.html { render action: 'new' }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metrics/1
  # PATCH/PUT /metrics/1.json
  def update
    respond_to do |format|
      if @metric.update(metric_params)
        format.html { redirect_to [@metric.service, @metric], notice: 'Metric was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metrics/1
  # DELETE /metrics/1.json
  def destroy
    @metric.destroy
    respond_to do |format|
      format.html { redirect_to service_metrics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric
      @metric = @service.metrics.find(params[:id]) if @service
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_params
      params.require(:metric).permit(:name, :settings, :model_name, :attr, :transform, :service_id)
    end

    # Get service that has the service
    def set_service
      @service = Service.find(params[:service_id])
    end
end
