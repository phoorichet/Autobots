require 'test_helper'

class MetricHttpsControllerTest < ActionController::TestCase
  setup do
    @metric_http = metric_https(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metric_https)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric_http" do
    assert_difference('MetricHttp.count') do
      post :create, metric_http: { apn: @metric_http.apn, attempt: @metric_http.attempt, http_succ_rate: @metric_http.http_succ_rate, imei: @metric_http.imei, imsi: @metric_http.imsi, location: @metric_http.location, mobile_code: @metric_http.mobile_code, region: @metric_http.region, rncname: @metric_http.rncname, script_name: @metric_http.script_name, serviceinfo: @metric_http.serviceinfo, success: @metric_http.success }
    end

    assert_redirected_to metric_http_path(assigns(:metric_http))
  end

  test "should show metric_http" do
    get :show, id: @metric_http
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metric_http
    assert_response :success
  end

  test "should update metric_http" do
    patch :update, id: @metric_http, metric_http: { apn: @metric_http.apn, attempt: @metric_http.attempt, http_succ_rate: @metric_http.http_succ_rate, imei: @metric_http.imei, imsi: @metric_http.imsi, location: @metric_http.location, mobile_code: @metric_http.mobile_code, region: @metric_http.region, rncname: @metric_http.rncname, script_name: @metric_http.script_name, serviceinfo: @metric_http.serviceinfo, success: @metric_http.success }
    assert_redirected_to metric_http_path(assigns(:metric_http))
  end

  test "should destroy metric_http" do
    assert_difference('MetricHttp.count', -1) do
      delete :destroy, id: @metric_http
    end

    assert_redirected_to metric_https_path
  end
end
