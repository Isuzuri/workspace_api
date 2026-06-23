class Task < ApplicationRecord
  belongs_to :assignee, class_name: "User"
  belongs_to :project

  enum :status, { todo: 0, in_progress: 1, done: 2 }
  enum :priority, { low: 0, medium: 1, high: 2 }

  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_priority, ->(priority) { where(priority: priority) if priority.present? }
  scope :by_deadline_less_than, ->(date) { where("deadline < ?", date) if date.present? }
  scope :by_assignee, ->(user_id) { where(assignee_id: user_id) if user_id.present? }
end
