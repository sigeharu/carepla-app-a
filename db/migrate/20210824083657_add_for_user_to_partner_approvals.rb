class AddForUserToPartnerApprovals < ActiveRecord::Migration[6.1]
  def change
    add_column :partner_approvals, :for_user, :integer
  end
end
