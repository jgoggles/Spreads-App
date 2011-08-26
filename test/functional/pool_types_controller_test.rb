require 'test_helper'

class PoolTypesControllerTest < ActionController::TestCase
  setup do
    @pool_type = pool_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pool_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pool_type" do
    assert_difference('PoolType.count') do
      post :create, pool_type: @pool_type.attributes
    end

    assert_redirected_to pool_type_path(assigns(:pool_type))
  end

  test "should show pool_type" do
    get :show, id: @pool_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pool_type.to_param
    assert_response :success
  end

  test "should update pool_type" do
    put :update, id: @pool_type.to_param, pool_type: @pool_type.attributes
    assert_redirected_to pool_type_path(assigns(:pool_type))
  end

  test "should destroy pool_type" do
    assert_difference('PoolType.count', -1) do
      delete :destroy, id: @pool_type.to_param
    end

    assert_redirected_to pool_types_path
  end
end
