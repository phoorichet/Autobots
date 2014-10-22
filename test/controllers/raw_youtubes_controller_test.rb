require 'test_helper'

class RawYoutubesControllerTest < ActionController::TestCase
  setup do
    @raw_youtube = raw_youtubes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_youtubes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_youtube" do
    assert_difference('RawYoutube.count') do
      post :create, raw_youtube: { apn: @raw_youtube.apn, avg_ecio: @raw_youtube.avg_ecio, avg_rssi: @raw_youtube.avg_rssi, avg_rxlen: @raw_youtube.avg_rxlen, cell_id: @raw_youtube.cell_id, data_download_transfer: @raw_youtube.data_download_transfer, duration_time: @raw_youtube.duration_time, imei: @raw_youtube.imei, imsi: @raw_youtube.imsi, lac: @raw_youtube.lac, lat: @raw_youtube.lat, lon: @raw_youtube.lon, operator: @raw_youtube.operator, result: @raw_youtube.result, result_detail: @raw_youtube.result_detail, script_name: @raw_youtube.script_name, start_time: @raw_youtube.start_time, stop_time: @raw_youtube.stop_time, technology: @raw_youtube.technology, throughput_download_app: @raw_youtube.throughput_download_app, throughput_download_rlc: @raw_youtube.throughput_download_rlc, youtube_video_duration: @raw_youtube.youtube_video_duration }
    end

    assert_redirected_to raw_youtube_path(assigns(:raw_youtube))
  end

  test "should show raw_youtube" do
    get :show, id: @raw_youtube
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_youtube
    assert_response :success
  end

  test "should update raw_youtube" do
    patch :update, id: @raw_youtube, raw_youtube: { apn: @raw_youtube.apn, avg_ecio: @raw_youtube.avg_ecio, avg_rssi: @raw_youtube.avg_rssi, avg_rxlen: @raw_youtube.avg_rxlen, cell_id: @raw_youtube.cell_id, data_download_transfer: @raw_youtube.data_download_transfer, duration_time: @raw_youtube.duration_time, imei: @raw_youtube.imei, imsi: @raw_youtube.imsi, lac: @raw_youtube.lac, lat: @raw_youtube.lat, lon: @raw_youtube.lon, operator: @raw_youtube.operator, result: @raw_youtube.result, result_detail: @raw_youtube.result_detail, script_name: @raw_youtube.script_name, start_time: @raw_youtube.start_time, stop_time: @raw_youtube.stop_time, technology: @raw_youtube.technology, throughput_download_app: @raw_youtube.throughput_download_app, throughput_download_rlc: @raw_youtube.throughput_download_rlc, youtube_video_duration: @raw_youtube.youtube_video_duration }
    assert_redirected_to raw_youtube_path(assigns(:raw_youtube))
  end

  test "should destroy raw_youtube" do
    assert_difference('RawYoutube.count', -1) do
      delete :destroy, id: @raw_youtube
    end

    assert_redirected_to raw_youtubes_path
  end
end
