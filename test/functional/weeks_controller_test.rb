require 'test_helper'

class WeeksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Week.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Week.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Week.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to week_url(assigns(:week))
  end

  def test_edit
    get :edit, :id => Week.first
    assert_template 'edit'
  end

  def test_update_invalid
    Week.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Week.first
    assert_template 'edit'
  end

  def test_update_valid
    Week.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Week.first
    assert_redirected_to week_url(assigns(:week))
  end

  def test_destroy
    week = Week.first
    delete :destroy, :id => week
    assert_redirected_to weeks_url
    assert !Week.exists?(week.id)
  end
end
