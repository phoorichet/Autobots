require 'test_helper'

class RawPingsControllerTest < ActionController::TestCase
  setup do
    @raw_ping = raw_pings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_pings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_ping" do
    assert_difference('RawPing.count') do
      post :create, raw_ping: { apn: @raw_ping.apn, apn_mcc: @raw_ping.apn_mcc, apn_mnc: @raw_ping.apn_mnc, cell_id: @raw_ping.cell_id, datetime: @raw_ping.datetime, imei: @raw_ping.imei, imsi: @raw_ping.imsi, ip: @raw_ping.ip, lac: @raw_ping.lac, packet_lost: @raw_ping.packet_lost, packet_received: @raw_ping.packet_received, packet_sent: @raw_ping.packet_sent, packet_size: @raw_ping.packet_size, rtt_max: @raw_ping.rtt_max, rtt_mdev: @raw_ping.rtt_mdev, rtt_min: @raw_ping.rtt_min, script_name: @raw_ping.script_name, technology: @raw_ping.technology }
    end

    assert_redirected_to raw_ping_path(assigns(:raw_ping))
  end

  test "should show raw_ping" do
    get :show, id: @raw_ping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_ping
    assert_response :success
  end

  test "should update raw_ping" do
    patch :update, id: @raw_ping, raw_ping: { apn: @raw_ping.apn, apn_mcc: @raw_ping.apn_mcc, apn_mnc: @raw_ping.apn_mnc, cell_id: @raw_ping.cell_id, datetime: @raw_ping.datetime, imei: @raw_ping.imei, imsi: @raw_ping.imsi, ip: @raw_ping.ip, lac: @raw_ping.lac, packet_lost: @raw_ping.packet_lost, packet_received: @raw_ping.packet_received, packet_sent: @raw_ping.packet_sent, packet_size: @raw_ping.packet_size, rtt_max: @raw_ping.rtt_max, rtt_mdev: @raw_ping.rtt_mdev, rtt_min: @raw_ping.rtt_min, script_name: @raw_ping.script_name, technology: @raw_ping.technology }
    assert_redirected_to raw_ping_path(assigns(:raw_ping))
  end

  test "should destroy raw_ping" do
    assert_difference('RawPing.count', -1) do
      delete :destroy, id: @raw_ping
    end

    assert_redirected_to raw_pings_path
  end
end
