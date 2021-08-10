class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :schedule
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
