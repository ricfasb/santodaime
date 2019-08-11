require 'test_helper'

class LeansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lean = leans(:one)
  end

  test "should get index" do
    get leans_url
    assert_response :success
  end

  test "should get new" do
    get new_lean_url
    assert_response :success
  end

  test "should create lean" do
    assert_difference('Lean.count') do
      post leans_url, params: { lean: { company_id: @lean.company_id, devolution: @lean.devolution } }
    end

    assert_redirected_to lean_url(Lean.last)
  end

  test "should show lean" do
    get lean_url(@lean)
    assert_response :success
  end

  test "should get edit" do
    get edit_lean_url(@lean)
    assert_response :success
  end

  test "should update lean" do
    patch lean_url(@lean), params: { lean: { company_id: @lean.company_id, devolution: @lean.devolution } }
    assert_redirected_to lean_url(@lean)
  end

  test "should destroy lean" do
    assert_difference('Lean.count', -1) do
      delete lean_url(@lean)
    end

    assert_redirected_to leans_url
  end
end
