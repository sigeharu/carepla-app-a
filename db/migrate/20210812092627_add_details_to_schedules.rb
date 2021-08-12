class AddDetailsToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :takeover, :boolean, default: false
  end
end
