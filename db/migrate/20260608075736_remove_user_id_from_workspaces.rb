class RemoveUserIdFromWorkspaces < ActiveRecord::Migration[8.1]
  def change
    remove_column :workspaces, :user_id, :integer
  end
end
