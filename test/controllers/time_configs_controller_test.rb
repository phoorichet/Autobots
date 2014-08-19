require 'test_helper'

class TimeConfigsControllerTest < ActionController::TestCase
  setup do
    @time_config = time_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_config" do
    assert_difference('TimeConfig.count') do
      post :create, time_config: { description: @time_config.description, name: @time_config.name, reps: @time_config.reps, time_type: @time_config.time_type }
    end

    assert_redirected_to time_config_path(assigns(:time_config))
  end

  test "should show time_config" do
    get :show, id: @time_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_config
    assert_response :success
  end

  test "should update time_config" do
    patch :update, id: @time_config, time_config: { description: @time_config.description, name: @time_config.name, reps: @time_config.reps, time_type: @time_config.time_type }
    assert_redirected_to time_config_path(assigns(:time_config))
  end

  test "should destroy time_config" do
    assert_difference('TimeConfig.count', -1) do
      delete :destroy, id: @time_config
    end

    assert_redirected_to time_configs_path
  end
end
