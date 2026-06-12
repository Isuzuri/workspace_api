class Projects::CreateService
  def initialize(user:, workspace:, params:)
    @user = user
    @workspace = workspace
    @params = params
  end

  def call
    Project.transaction do
      project = @workspace.projects.create!(@params)
      project.project_memberships.create!(user: @user, role: :owner)
      project
    end
  end
end
