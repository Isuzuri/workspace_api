class Project < ApplicationRecord
  belongs_to :workspace
  has_many :project_memberships, dependent: :destroy
  has_many :users, through: :project_memberships
  has_many :tasks
end
