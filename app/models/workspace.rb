class Workspace < ApplicationRecord
  belongs_to :user

  has_many :memberships
  has_many :users, through: :memberships

  after_create :add_owner_to_memberships

  private

  def add_owner_to_memberships
    memberships.create(user: user, role: :owner)
  end
end
