require 'test_helper'

class RawHttpsControllerTest < ActionController::TestCase
  setup do
    @raw_http = raw_https(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_https)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_http" do
    assert_difference('RawHttp.count') do
      post :create, raw_http: { agv_rssi: @raw_http.agv_rssi, apn: @raw_http.apn, avg_ecio: @raw_http.avg_ecio, avg_rxlev: @raw_http.avg_rxlev, cell_id: @raw_http.cell_id, connecting_time_1: @raw_http.connecting_time_1, data_download_transfer: @raw_http.data_download_transfer, duration_time: @raw_http.duration_time, imei: @raw_http.imei, imsi: @raw_http.imsi, lac: @raw_http.lac, lat: @raw_http.lat, lon: @raw_http.lon, max_download: @raw_http.max_download, max_download_overall: @raw_http.max_download_overall, min_download: @raw_http.min_download, result: @raw_http.result, result_1: @raw_http.result_1, result_detail_1: @raw_http.result_detail_1, script_name: @raw_http.script_name, service: @raw_http.service, service_info: @raw_http.service_info, start_date: @raw_http.start_date, stop_date: @raw_http.stop_date, throughput_download_app: @raw_http.throughput_download_app, throughput_download_ip: @raw_http.throughput_download_ip, throughput_download_rlc: @raw_http.throughput_download_rlc, time_to_first_byte_1: @raw_http.time_to_first_byte_1 }
    end

    assert_redirected_to raw_http_path(assigns(:raw_http))
  end

  test "should show raw_http" do
    get :show, id: @raw_http
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_http
    assert_response :success
  end

  test "should update raw_http" do
    patch :update, id: @raw_http, raw_http: { agv_rssi: @raw_http.agv_rssi, apn: @raw_http.apn, avg_ecio: @raw_http.avg_ecio, avg_rxlev: @raw_http.avg_rxlev, cell_id: @raw_http.cell_id, connecting_time_1: @raw_http.connecting_time_1, data_download_transfer: @raw_http.data_download_transfer, duration_time: @raw_http.duration_time, imei: @raw_http.imei, imsi: @raw_http.imsi, lac: @raw_http.lac, lat: @raw_http.lat, lon: @raw_http.lon, max_download: @raw_http.max_download, max_download_overall: @raw_http.max_download_overall, min_download: @raw_http.min_download, result: @raw_http.result, result_1: @raw_http.result_1, result_detail_1: @raw_http.result_detail_1, script_name: @raw_http.script_name, service: @raw_http.service, service_info: @raw_http.service_info, start_date: @raw_http.start_date, stop_date: @raw_http.stop_date, throughput_download_app: @raw_http.throughput_download_app, throughput_download_ip: @raw_http.throughput_download_ip, throughput_download_rlc: @raw_http.throughput_download_rlc, time_to_first_byte_1: @raw_http.time_to_first_byte_1 }
    assert_redirected_to raw_http_path(assigns(:raw_http))
  end

  test "should destroy raw_http" do
    assert_difference('RawHttp.count', -1) do
      delete :destroy, id: @raw_http
    end

    assert_redirected_to raw_https_path
  end
end
