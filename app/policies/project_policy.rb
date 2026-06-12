class ProjectPolicy < ApplicationPolicy
  def index?
    project_memberships.present?
  end

  def show?
    project_memberships.present?
  end

  def update?
    project_memberships&.admin? || project_memberships&.owner?
  end

  def destroy?
    project_memberships&.owner?
  end

  private

  def project_membership
    record.project_memberships.find_by(user: user)
  end
end
