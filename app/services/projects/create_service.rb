class Projects::CreateService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    Project.transaction do
      workspace = Workspace.find(@params[:workspace_id])
      project = workspace.projects.create!(@params.slice(:name, :description))
      project.project_memberships.create!(user: @user, role: :owner)
      project
    end
  end
end
