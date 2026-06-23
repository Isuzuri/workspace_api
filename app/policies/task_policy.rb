class TaskPolicy < ApplicationPolicy
  def update?
    project_role&.present?
  end

  def destroy?
    project_role&.admin? || project_role&.owner?
  end

  private

  def project_role
    record.project.project_memberships.find_by(user: user)
  end
end
