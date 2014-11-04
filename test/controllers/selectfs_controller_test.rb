require 'test_helper'

class SelectfsControllerTest < ActionController::TestCase
  setup do
    @selectf = selectfs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selectfs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create selectf" do
    assert_difference('Selectf.count') do
      post :create, selectf: { field: @selectf.field, metric_id: @selectf.metric_id, selected: @selectf.selected }
    end

    assert_redirected_to selectf_path(assigns(:selectf))
  end

  test "should show selectf" do
    get :show, id: @selectf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @selectf
    assert_response :success
  end

  test "should update selectf" do
    patch :update, id: @selectf, selectf: { field: @selectf.field, metric_id: @selectf.metric_id, selected: @selectf.selected }
    assert_redirected_to selectf_path(assigns(:selectf))
  end

  test "should destroy selectf" do
    assert_difference('Selectf.count', -1) do
      delete :destroy, id: @selectf
    end

    assert_redirected_to selectfs_path
  end
end
