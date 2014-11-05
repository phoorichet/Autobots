require 'test_helper'

class MsLocationsControllerTest < ActionController::TestCase
  setup do
    @ms_location = ms_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ms_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ms_location" do
    assert_difference('MsLocation.count') do
      post :create, ms_location: { building_id: @ms_location.building_id, imei: @ms_location.imei, location: @ms_location.location, mini_box: @ms_location.mini_box, mobile_code: @ms_location.mobile_code, mobile_no: @ms_location.mobile_no, region: @ms_location.region, rncname: @ms_location.rncname, serial_no: @ms_location.serial_no }
    end

    assert_redirected_to ms_location_path(assigns(:ms_location))
  end

  test "should show ms_location" do
    get :show, id: @ms_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ms_location
    assert_response :success
  end

  test "should update ms_location" do
    patch :update, id: @ms_location, ms_location: { building_id: @ms_location.building_id, imei: @ms_location.imei, location: @ms_location.location, mini_box: @ms_location.mini_box, mobile_code: @ms_location.mobile_code, mobile_no: @ms_location.mobile_no, region: @ms_location.region, rncname: @ms_location.rncname, serial_no: @ms_location.serial_no }
    assert_redirected_to ms_location_path(assigns(:ms_location))
  end

  test "should destroy ms_location" do
    assert_difference('MsLocation.count', -1) do
      delete :destroy, id: @ms_location
    end

    assert_redirected_to ms_locations_path
  end
end
