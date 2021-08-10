class AddScheduleDateToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :schedule_date, :datetime
  end
end
