class Projects::CreateService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    Project.transaction do
      project = Project.create!(@params)
      project.project_memberships.create!(user: @user, role: :owner)
      project
    end
  end
end
