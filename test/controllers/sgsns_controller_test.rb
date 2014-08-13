require 'test_helper'

class SgsnsControllerTest < ActionController::TestCase
  setup do
    @sgsn = sgsns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sgsns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sgsn" do
    assert_difference('Sgsn.count') do
      post :create, sgsn: { name: @sgsn.name }
    end

    assert_redirected_to sgsn_path(assigns(:sgsn))
  end

  test "should show sgsn" do
    get :show, id: @sgsn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sgsn
    assert_response :success
  end

  test "should update sgsn" do
    patch :update, id: @sgsn, sgsn: { name: @sgsn.name }
    assert_redirected_to sgsn_path(assigns(:sgsn))
  end

  test "should destroy sgsn" do
    assert_difference('Sgsn.count', -1) do
      delete :destroy, id: @sgsn
    end

    assert_redirected_to sgsns_path
  end
end
