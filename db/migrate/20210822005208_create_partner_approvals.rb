class CreatePartnerApprovals < ActiveRecord::Migration[6.1]
  def change
    create_table :partner_approvals do |t|
      t.boolean :partner_approval, default: false
      t.text :comment

      t.timestamps
    end
  end
end
