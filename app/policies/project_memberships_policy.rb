class ProjectMembershipsPolicy < ApplicationPolicy
  def index?
    acting_membership.present?
  end

  def create?
    acting_membership&.owner? || acting_membership&.admin?
  end

  def destroy?
    acting_membership&.owner? || (acting_membership&.admin? && !record.owner?)
  end

  def update?
    destroy?
  end

  private

  def acting_membership
    project.project_memberships.find_by(user: user)
  end

  def project
    record.is_a?(Project) ? record : record.project
  end
end
