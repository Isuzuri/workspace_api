class Workspaces::CreateService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    Workspace.transaction do
      workspace = Workspace.create!(@params)
      workspace.memberships.create!(user: @user, role: :owner )
      workspace
    end
  end
end