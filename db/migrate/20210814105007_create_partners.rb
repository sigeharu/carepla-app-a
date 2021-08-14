class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners do |t|
      t.string :partner_group, null: false
      t.text :partner_group_description

      t.timestamps
    end
  end
end
