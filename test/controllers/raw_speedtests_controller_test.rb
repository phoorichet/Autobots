require 'test_helper'

class RawSpeedtestsControllerTest < ActionController::TestCase
  setup do
    @raw_speedtest = raw_speedtests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_speedtests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_speedtest" do
    assert_difference('RawSpeedtest.count') do
      post :create, raw_speedtest: { apn: @raw_speedtest.apn, avg_ecio: @raw_speedtest.avg_ecio, avg_rssi: @raw_speedtest.avg_rssi, cell_id: @raw_speedtest.cell_id, datetime: @raw_speedtest.datetime, download: @raw_speedtest.download, imei: @raw_speedtest.imei, imsi: @raw_speedtest.imsi, lac: @raw_speedtest.lac, latency: @raw_speedtest.latency, mcc: @raw_speedtest.mcc, mcc: @raw_speedtest.mcc, operator: @raw_speedtest.operator, result: @raw_speedtest.result, script_name: @raw_speedtest.script_name, server_id: @raw_speedtest.server_id, server_name: @raw_speedtest.server_name, set_server_id: @raw_speedtest.set_server_id, set_server_name: @raw_speedtest.set_server_name, technology: @raw_speedtest.technology, upload: @raw_speedtest.upload }
    end

    assert_redirected_to raw_speedtest_path(assigns(:raw_speedtest))
  end

  test "should show raw_speedtest" do
    get :show, id: @raw_speedtest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_speedtest
    assert_response :success
  end

  test "should update raw_speedtest" do
    patch :update, id: @raw_speedtest, raw_speedtest: { apn: @raw_speedtest.apn, avg_ecio: @raw_speedtest.avg_ecio, avg_rssi: @raw_speedtest.avg_rssi, cell_id: @raw_speedtest.cell_id, datetime: @raw_speedtest.datetime, download: @raw_speedtest.download, imei: @raw_speedtest.imei, imsi: @raw_speedtest.imsi, lac: @raw_speedtest.lac, latency: @raw_speedtest.latency, mcc: @raw_speedtest.mcc, mcc: @raw_speedtest.mcc, operator: @raw_speedtest.operator, result: @raw_speedtest.result, script_name: @raw_speedtest.script_name, server_id: @raw_speedtest.server_id, server_name: @raw_speedtest.server_name, set_server_id: @raw_speedtest.set_server_id, set_server_name: @raw_speedtest.set_server_name, technology: @raw_speedtest.technology, upload: @raw_speedtest.upload }
    assert_redirected_to raw_speedtest_path(assigns(:raw_speedtest))
  end

  test "should destroy raw_speedtest" do
    assert_difference('RawSpeedtest.count', -1) do
      delete :destroy, id: @raw_speedtest
    end

    assert_redirected_to raw_speedtests_path
  end
end
