class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.string :comment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
