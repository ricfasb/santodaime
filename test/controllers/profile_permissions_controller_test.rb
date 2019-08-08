require 'test_helper'

class ProfilePermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_permission = profile_permissions(:one)
  end

  test "should get index" do
    get profile_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_permission_url
    assert_response :success
  end

  test "should create profile_permission" do
    assert_difference('ProfilePermission.count') do
      post profile_permissions_url, params: { profile_permission: { permission_id: @profile_permission.permission_id, profile_id: @profile_permission.profile_id } }
    end

    assert_redirected_to profile_permission_url(ProfilePermission.last)
  end

  test "should show profile_permission" do
    get profile_permission_url(@profile_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_permission_url(@profile_permission)
    assert_response :success
  end

  test "should update profile_permission" do
    patch profile_permission_url(@profile_permission), params: { profile_permission: { permission_id: @profile_permission.permission_id, profile_id: @profile_permission.profile_id } }
    assert_redirected_to profile_permission_url(@profile_permission)
  end

  test "should destroy profile_permission" do
    assert_difference('ProfilePermission.count', -1) do
      delete profile_permission_url(@profile_permission)
    end

    assert_redirected_to profile_permissions_url
  end
end
