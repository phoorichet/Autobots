require 'test_helper'

class RncsControllerTest < ActionController::TestCase
  setup do
    @rnc = rncs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rncs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rnc" do
    assert_difference('Rnc.count') do
      post :create, rnc: { name: @rnc.name, sgsn_id: @rnc.sgsn_id }
    end

    assert_redirected_to rnc_path(assigns(:rnc))
  end

  test "should show rnc" do
    get :show, id: @rnc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rnc
    assert_response :success
  end

  test "should update rnc" do
    patch :update, id: @rnc, rnc: { name: @rnc.name, sgsn_id: @rnc.sgsn_id }
    assert_redirected_to rnc_path(assigns(:rnc))
  end

  test "should destroy rnc" do
    assert_difference('Rnc.count', -1) do
      delete :destroy, id: @rnc
    end

    assert_redirected_to rncs_path
  end
end
