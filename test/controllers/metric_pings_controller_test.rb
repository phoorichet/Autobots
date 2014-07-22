require 'test_helper'

class MetricPingsControllerTest < ActionController::TestCase
  setup do
    @metric_ping = metric_pings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metric_pings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric_ping" do
    assert_difference('MetricPing.count') do
      post :create, metric_ping: { attempt: @metric_ping.attempt, avg_packet_loss_rate: @metric_ping.avg_packet_loss_rate, avg_rtt_succ_rate: @metric_ping.avg_rtt_succ_rate, imei: @metric_ping.imei, imsi: @metric_ping.imsi, location: @metric_ping.location, mobile_code: @metric_ping.mobile_code, percent_loss: @metric_ping.percent_loss, region: @metric_ping.region, rncname: @metric_ping.rncname, target_ip: @metric_ping.target_ip }
    end

    assert_redirected_to metric_ping_path(assigns(:metric_ping))
  end

  test "should show metric_ping" do
    get :show, id: @metric_ping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metric_ping
    assert_response :success
  end

  test "should update metric_ping" do
    patch :update, id: @metric_ping, metric_ping: { attempt: @metric_ping.attempt, avg_packet_loss_rate: @metric_ping.avg_packet_loss_rate, avg_rtt_succ_rate: @metric_ping.avg_rtt_succ_rate, imei: @metric_ping.imei, imsi: @metric_ping.imsi, location: @metric_ping.location, mobile_code: @metric_ping.mobile_code, percent_loss: @metric_ping.percent_loss, region: @metric_ping.region, rncname: @metric_ping.rncname, target_ip: @metric_ping.target_ip }
    assert_redirected_to metric_ping_path(assigns(:metric_ping))
  end

  test "should destroy metric_ping" do
    assert_difference('MetricPing.count', -1) do
      delete :destroy, id: @metric_ping
    end

    assert_redirected_to metric_pings_path
  end
end
