require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get report_index_url
    assert_response :success
  end

  test "should get generate_report" do
    get report_generate_report_url
    assert_response :success
  end

  test "should get save_report" do
    get report_save_report_url
    assert_response :success
  end

end
