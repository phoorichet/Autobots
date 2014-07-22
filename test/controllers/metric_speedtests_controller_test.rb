require 'test_helper'

class MetricSpeedtestsControllerTest < ActionController::TestCase
  setup do
    @metric_speedtest = metric_speedtests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metric_speedtests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric_speedtest" do
    assert_difference('MetricSpeedtest.count') do
      post :create, metric_speedtest: { attempt: @metric_speedtest.attempt, download_1mbps: @metric_speedtest.download_1mbps, download_2mbps: @metric_speedtest.download_2mbps, imei: @metric_speedtest.imei, imsi: @metric_speedtest.imsi, latency_300ms: @metric_speedtest.latency_300ms, location: @metric_speedtest.location, mobile_code: @metric_speedtest.mobile_code, region: @metric_speedtest.region, rncname: @metric_speedtest.rncname, script_name: @metric_speedtest.script_name, set_server_name: @metric_speedtest.set_server_name, speedtest_dl_1m_rate: @metric_speedtest.speedtest_dl_1m_rate, speedtest_dl_2m_rate: @metric_speedtest.speedtest_dl_2m_rate, speedtest_lt_300k_rate: @metric_speedtest.speedtest_lt_300k_rate, speedtest_ul_1m_rate: @metric_speedtest.speedtest_ul_1m_rate, speedtest_ul_300k_rate: @metric_speedtest.speedtest_ul_300k_rate, upload_1mkbps: @metric_speedtest.upload_1mkbps, upload_300kbps: @metric_speedtest.upload_300kbps }
    end

    assert_redirected_to metric_speedtest_path(assigns(:metric_speedtest))
  end

  test "should show metric_speedtest" do
    get :show, id: @metric_speedtest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metric_speedtest
    assert_response :success
  end

  test "should update metric_speedtest" do
    patch :update, id: @metric_speedtest, metric_speedtest: { attempt: @metric_speedtest.attempt, download_1mbps: @metric_speedtest.download_1mbps, download_2mbps: @metric_speedtest.download_2mbps, imei: @metric_speedtest.imei, imsi: @metric_speedtest.imsi, latency_300ms: @metric_speedtest.latency_300ms, location: @metric_speedtest.location, mobile_code: @metric_speedtest.mobile_code, region: @metric_speedtest.region, rncname: @metric_speedtest.rncname, script_name: @metric_speedtest.script_name, set_server_name: @metric_speedtest.set_server_name, speedtest_dl_1m_rate: @metric_speedtest.speedtest_dl_1m_rate, speedtest_dl_2m_rate: @metric_speedtest.speedtest_dl_2m_rate, speedtest_lt_300k_rate: @metric_speedtest.speedtest_lt_300k_rate, speedtest_ul_1m_rate: @metric_speedtest.speedtest_ul_1m_rate, speedtest_ul_300k_rate: @metric_speedtest.speedtest_ul_300k_rate, upload_1mkbps: @metric_speedtest.upload_1mkbps, upload_300kbps: @metric_speedtest.upload_300kbps }
    assert_redirected_to metric_speedtest_path(assigns(:metric_speedtest))
  end

  test "should destroy metric_speedtest" do
    assert_difference('MetricSpeedtest.count', -1) do
      delete :destroy, id: @metric_speedtest
    end

    assert_redirected_to metric_speedtests_path
  end
end
