require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groups_index_url
    assert_response :success
  end

  test "should get new" do
    get groups_new_url
    assert_response :success
  end

  test "should get create" do
    get groups_create_url
    assert_response :success
  end

  test "should get destroy" do
    get groups_destroy_url
    assert_response :success
  end

  test "should get add_user" do
    get groups_add_user_url
    assert_response :success
  end

  test "should get create_user" do
    get groups_create_user_url
    assert_response :success
  end

  test "should get destroy_user" do
    get groups_destroy_user_url
    assert_response :success
  end
end
