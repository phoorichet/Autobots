class TimeConfigsController < ApplicationController
  before_action :set_time_config, only: [:show, :edit, :update, :destroy]

  # GET /time_configs
  # GET /time_configs.json
  def index
    @time_configs = TimeConfig.all
  end

  # GET /time_configs/1
  # GET /time_configs/1.json
  def show
  end

  # GET /time_configs/new
  def new
    @time_config = TimeConfig.new
  end

  # GET /time_configs/1/edit
  def edit
  end

  # POST /time_configs
  # POST /time_configs.json
  def create
    @time_config = TimeConfig.new(time_config_params)

    respond_to do |format|
      if @time_config.save
        format.html { redirect_to @time_config, notice: 'Time config was successfully created.' }
        format.json { render action: 'show', status: :created, location: @time_config }
      else
        format.html { render action: 'new' }
        format.json { render json: @time_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_configs/1
  # PATCH/PUT /time_configs/1.json
  def update
    respond_to do |format|
      if @time_config.update(time_config_params)
        format.html { redirect_to @time_config, notice: 'Time config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @time_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_configs/1
  # DELETE /time_configs/1.json
  def destroy
    @time_config.destroy
    respond_to do |format|
      format.html { redirect_to time_configs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_config
      @time_config = TimeConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_config_params
      params.require(:time_config).permit(:name, :description, :start, :stop, :interval, :time_type)
    end
end
