class RenameScheduleColumnToSchedules < ActiveRecord::Migration[6.1]
  def change
    rename_column :schedules, :schedule, :title
  end
end
