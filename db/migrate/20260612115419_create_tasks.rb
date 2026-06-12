class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description
      t.references :assignee, foreign_key: { to_table: :users }
      t.integer :status, null: false, default: 0
      t.integer :priority
      t.date :deadline
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
