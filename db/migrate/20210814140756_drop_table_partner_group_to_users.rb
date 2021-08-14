class DropTablePartnerGroupToUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :partner_group_to_users do |t|
      t.bigint "partner_id"
      t.bigint "user_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["partner_id"], name: "index_partner_group_to_users_on_partner_id"
      t.index ["user_id"], name: "index_partner_group_to_users_on_user_id"
    end
  end
end
