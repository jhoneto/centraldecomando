require 'test_helper'

class SpecificationFieldsControllerTest < ActionController::TestCase
  setup do
    @specification_field = specification_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:specification_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create specification_field" do
    assert_difference('SpecificationField.count') do
      post :create, :specification_field => @specification_field.attributes
    end

    assert_redirected_to specification_field_path(assigns(:specification_field))
  end

  test "should show specification_field" do
    get :show, :id => @specification_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @specification_field.to_param
    assert_response :success
  end

  test "should update specification_field" do
    put :update, :id => @specification_field.to_param, :specification_field => @specification_field.attributes
    assert_redirected_to specification_field_path(assigns(:specification_field))
  end

  test "should destroy specification_field" do
    assert_difference('SpecificationField.count', -1) do
      delete :destroy, :id => @specification_field.to_param
    end

    assert_redirected_to specification_fields_path
  end
end
