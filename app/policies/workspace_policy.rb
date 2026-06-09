class WorkspacePolicy < ApplicationPolicy
  def index?
    membership.present?
  end

  def show?
    membership.present?
  end

  def update?
    membership&.admin? || membership&.owner?
  end

  def destroy?
    membership&.owner?
  end

  def invite?
    membership.present?
  end

  def exclude?
    membership&.admin? || membership&.owner?
  end

  def change_role?
    membership&.owner?
  end

  private

  def membership
    record.memberships.find_by(user: user)
  end
end
