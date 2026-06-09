class MembershipPolicy < ApplicationPolicy
  def invite?
    acting_membership.present?
  end

  def exclude?
    acting_membership&.owner? || (acting_membership&.admin? && !record&.owner?)
  end

  def change_role?
    acting_membership&.owner? || (acting_membership&.admin? && !record&.owner?)
  end

  private

  def acting_membership
    record.workspace.memberships.find_by(user: user)
  end
end
