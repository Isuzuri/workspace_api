class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :memberships
  has_many :workspaces, through: :memberships

  has_many :project_memberships
  has_many :projects, through: :project_memberships
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assignee_id
end
