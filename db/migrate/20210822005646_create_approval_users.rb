class CreateApprovalUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :approval_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :partner_approval, index: true, foreign_key: true

      t.timestamps
    end
  end
end
