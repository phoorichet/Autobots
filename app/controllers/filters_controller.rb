class FiltersController < ApplicationController
  before_action :set_metric
  before_action :set_filter, only: [:show, :edit, :update, :destroy]

  # GET /filters
  # GET /filters.json
  def index
    @filters = @metric.filters.all
  end

  # GET /filters/1
  # GET /filters/1.json
  def show
  end

  # GET /filters/new
  def new
    @filter = @metric.filters.new
  end

  # GET /filters/1/edit
  def edit
  end

  # POST /filters
  # POST /filters.json
  def create
    @filter = @metric.filters.new(filter_params)

    respond_to do |format|
      if @filter.save
        format.html { redirect_to [@filter.metric, @filter], notice: 'Filter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @filter }
      else
        format.html { render action: 'new' }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filters/1
  # PATCH/PUT /filters/1.json
  def update
    respond_to do |format|
      if @filter.update(filter_params)
        format.html { redirect_to [@filter.metric, @filter], notice: 'Filter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filters/1
  # DELETE /filters/1.json
  def destroy
    @filter.destroy
    respond_to do |format|
      format.html { redirect_to [@metric.service, @metric] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filter
      @filter = Filter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filter_params
      params.require(:filter).permit(:field, :description, :operation, :operand, :operand_type)
    end

    # Get metric
    def set_metric
      @metric = Metric.find(params[:metric_id])
    end
end
