class AddCompletionToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :completion, :boolean, default: false
  end
end
