class ProjectPolicy < ApplicationPolicy
  def index?
    project_membership.present?
  end

  def show?
    project_membership.present?
  end

  def create?
    workspace_membership&.admin? || workspace_membership&.owner?
  end

  def update?
    project_membership&.admin? || project_membership&.owner?
  end

  def destroy?
    project_membership&.owner?
  end

  private

  def project_membership
    record.project_memberships.find_by(user: user)
  end

  def workspace_membership
    record.workspace&.memberships&.find_by(user: user)
  end
end
