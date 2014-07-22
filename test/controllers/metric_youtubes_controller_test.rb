require 'test_helper'

class MetricYoutubesControllerTest < ActionController::TestCase
  setup do
    @metric_youtube = metric_youtubes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metric_youtubes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric_youtube" do
    assert_difference('MetricYoutube.count') do
      post :create, metric_youtube: { attempt: @metric_youtube.attempt, imei: @metric_youtube.imei, imsi: @metric_youtube.imsi, location: @metric_youtube.location, mobile_code: @metric_youtube.mobile_code, quality: @metric_youtube.quality, region: @metric_youtube.region, rncname: @metric_youtube.rncname, script_name: @metric_youtube.script_name, success: @metric_youtube.success, youtube_qual_rate: @metric_youtube.youtube_qual_rate, youtube_rate: @metric_youtube.youtube_rate, youtube_succ_rate: @metric_youtube.youtube_succ_rate }
    end

    assert_redirected_to metric_youtube_path(assigns(:metric_youtube))
  end

  test "should show metric_youtube" do
    get :show, id: @metric_youtube
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metric_youtube
    assert_response :success
  end

  test "should update metric_youtube" do
    patch :update, id: @metric_youtube, metric_youtube: { attempt: @metric_youtube.attempt, imei: @metric_youtube.imei, imsi: @metric_youtube.imsi, location: @metric_youtube.location, mobile_code: @metric_youtube.mobile_code, quality: @metric_youtube.quality, region: @metric_youtube.region, rncname: @metric_youtube.rncname, script_name: @metric_youtube.script_name, success: @metric_youtube.success, youtube_qual_rate: @metric_youtube.youtube_qual_rate, youtube_rate: @metric_youtube.youtube_rate, youtube_succ_rate: @metric_youtube.youtube_succ_rate }
    assert_redirected_to metric_youtube_path(assigns(:metric_youtube))
  end

  test "should destroy metric_youtube" do
    assert_difference('MetricYoutube.count', -1) do
      delete :destroy, id: @metric_youtube
    end

    assert_redirected_to metric_youtubes_path
  end
end
