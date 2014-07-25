require 'test_helper'

class MetricsControllerTest < ActionController::TestCase
  setup do
    @metric = metrics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metrics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric" do
    assert_difference('Metric.count') do
      post :create, metric: { attr: @metric.attr, model_name: @metric.model_name, name: @metric.name, service_id: @metric.service_id, settings: @metric.settings, transform: @metric.transform }
    end

    assert_redirected_to metric_path(assigns(:metric))
  end

  test "should show metric" do
    get :show, id: @metric
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metric
    assert_response :success
  end

  test "should update metric" do
    patch :update, id: @metric, metric: { attr: @metric.attr, model_name: @metric.model_name, name: @metric.name, service_id: @metric.service_id, settings: @metric.settings, transform: @metric.transform }
    assert_redirected_to metric_path(assigns(:metric))
  end

  test "should destroy metric" do
    assert_difference('Metric.count', -1) do
      delete :destroy, id: @metric
    end

    assert_redirected_to metrics_path
  end
end
