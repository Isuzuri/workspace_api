require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
  end

  test "should get index" do
    get memberships_url, as: :json
    assert_response :success
  end

  test "should create membership" do
    assert_difference("Membership.count") do
      post memberships_url, params: { membership: { role: @membership.role, user_id: @membership.user_id, workspace_id: @membership.workspace_id } }, as: :json
    end

    assert_response :created
  end

  test "should show membership" do
    get membership_url(@membership), as: :json
    assert_response :success
  end

  test "should update membership" do
    patch membership_url(@membership), params: { membership: { role: @membership.role, user_id: @membership.user_id, workspace_id: @membership.workspace_id } }, as: :json
    assert_response :success
  end

  test "should destroy membership" do
    assert_difference("Membership.count", -1) do
      delete membership_url(@membership), as: :json
    end

    assert_response :no_content
  end
end
