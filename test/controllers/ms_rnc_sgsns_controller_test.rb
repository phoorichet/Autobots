require 'test_helper'

class MsRncSgsnsControllerTest < ActionController::TestCase
  setup do
    @ms_rnc_sgsn = ms_rnc_sgsns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ms_rnc_sgsns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ms_rnc_sgsn" do
    assert_difference('MsRncSgsn.count') do
      post :create, ms_rnc_sgsn: { rnc_name: @ms_rnc_sgsn.rnc_name, sgsn_name: @ms_rnc_sgsn.sgsn_name }
    end

    assert_redirected_to ms_rnc_sgsn_path(assigns(:ms_rnc_sgsn))
  end

  test "should show ms_rnc_sgsn" do
    get :show, id: @ms_rnc_sgsn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ms_rnc_sgsn
    assert_response :success
  end

  test "should update ms_rnc_sgsn" do
    patch :update, id: @ms_rnc_sgsn, ms_rnc_sgsn: { rnc_name: @ms_rnc_sgsn.rnc_name, sgsn_name: @ms_rnc_sgsn.sgsn_name }
    assert_redirected_to ms_rnc_sgsn_path(assigns(:ms_rnc_sgsn))
  end

  test "should destroy ms_rnc_sgsn" do
    assert_difference('MsRncSgsn.count', -1) do
      delete :destroy, id: @ms_rnc_sgsn
    end

    assert_redirected_to ms_rnc_sgsns_path
  end
end
