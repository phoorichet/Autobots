class VisualizationsController < ApplicationController
  before_action :set_visualization, only: [:show, :edit, :update, :destroy]

  # GET /visualizations
  # GET /visualizations.json
  def index
    @visualizations = Visualization.all
  end

  # GET /visualizations/1
  # GET /visualizations/1.json
  def show
  end

  # GET /visualizations/new
  def new
    @visualization = Visualization.new
  end

  # GET /visualizations/1/edit
  def edit
  end

  # POST /visualizations
  # POST /visualizations.json
  def create
    @visualization = Visualization.new(visualization_params)

    respond_to do |format|
      if @visualization.save
        format.html { redirect_to @visualization, notice: 'Visualization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @visualization }
      else
        format.html { render action: 'new' }
        format.json { render json: @visualization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visualizations/1
  # PATCH/PUT /visualizations/1.json
  def update
    respond_to do |format|
      if @visualization.update(visualization_params)
        format.html { redirect_to @visualization, notice: 'Visualization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visualization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visualizations/1
  # DELETE /visualizations/1.json
  def destroy
    @visualization.destroy
    respond_to do |format|
      format.html { redirect_to visualizations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visualization
      @visualization = Visualization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visualization_params
      params.require(:visualization).permit(:name, :view_path, :setting, :type, :config_file)
    end
end
