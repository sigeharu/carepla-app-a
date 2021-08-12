class AddTimenoneToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :time_none, :boolean, default: false
  end
end
