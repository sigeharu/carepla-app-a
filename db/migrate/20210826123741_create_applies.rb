class CreateApplies < ActiveRecord::Migration[6.1]
  def change
    create_table :applies do |t|
      t.references :user, index: true, foreign_key: true
      t.references :partner, index: true, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
