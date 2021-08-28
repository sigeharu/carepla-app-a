class AddFromUserToPartnerApprovals < ActiveRecord::Migration[6.1]
  def change
    add_column :partner_approvals, :from_user, :integer
  end
end
