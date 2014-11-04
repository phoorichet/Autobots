require 'test_helper'

class VspecsControllerTest < ActionController::TestCase
  setup do
    @vspec = vspecs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vspecs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vspec" do
    assert_difference('Vspec.count') do
      post :create, vspec: { metric_id: @vspec.metric_id, name: @vspec.name, value: @vspec.value }
    end

    assert_redirected_to vspec_path(assigns(:vspec))
  end

  test "should show vspec" do
    get :show, id: @vspec
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vspec
    assert_response :success
  end

  test "should update vspec" do
    patch :update, id: @vspec, vspec: { metric_id: @vspec.metric_id, name: @vspec.name, value: @vspec.value }
    assert_redirected_to vspec_path(assigns(:vspec))
  end

  test "should destroy vspec" do
    assert_difference('Vspec.count', -1) do
      delete :destroy, id: @vspec
    end

    assert_redirected_to vspecs_path
  end
end
