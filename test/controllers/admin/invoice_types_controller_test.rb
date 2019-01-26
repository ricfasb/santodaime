require 'test_helper'

class Admin::InvoiceTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_invoice_type = admin_invoice_types(:one)
  end

  test "should get index" do
    get admin_invoice_types_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_invoice_type_url
    assert_response :success
  end

  test "should create admin_invoice_type" do
    assert_difference('Admin::InvoiceType.count') do
      post admin_invoice_types_url, params: { admin_invoice_type: { description: @admin_invoice_type.description } }
    end

    assert_redirected_to admin_invoice_type_url(Admin::InvoiceType.last)
  end

  test "should show admin_invoice_type" do
    get admin_invoice_type_url(@admin_invoice_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_invoice_type_url(@admin_invoice_type)
    assert_response :success
  end

  test "should update admin_invoice_type" do
    patch admin_invoice_type_url(@admin_invoice_type), params: { admin_invoice_type: { description: @admin_invoice_type.description } }
    assert_redirected_to admin_invoice_type_url(@admin_invoice_type)
  end

  test "should destroy admin_invoice_type" do
    assert_difference('Admin::InvoiceType.count', -1) do
      delete admin_invoice_type_url(@admin_invoice_type)
    end

    assert_redirected_to admin_invoice_types_url
  end
end
