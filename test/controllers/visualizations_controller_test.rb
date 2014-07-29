require 'test_helper'

class VisualizationsControllerTest < ActionController::TestCase
  setup do
    @visualization = visualizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visualizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visualization" do
    assert_difference('Visualization.count') do
      post :create, visualization: { config_file: @visualization.config_file, name: @visualization.name, setting: @visualization.setting, type: @visualization.type, view_path: @visualization.view_path }
    end

    assert_redirected_to visualization_path(assigns(:visualization))
  end

  test "should show visualization" do
    get :show, id: @visualization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visualization
    assert_response :success
  end

  test "should update visualization" do
    patch :update, id: @visualization, visualization: { config_file: @visualization.config_file, name: @visualization.name, setting: @visualization.setting, type: @visualization.type, view_path: @visualization.view_path }
    assert_redirected_to visualization_path(assigns(:visualization))
  end

  test "should destroy visualization" do
    assert_difference('Visualization.count', -1) do
      delete :destroy, id: @visualization
    end

    assert_redirected_to visualizations_path
  end
end
