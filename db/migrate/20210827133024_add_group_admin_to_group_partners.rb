class AddGroupAdminToGroupPartners < ActiveRecord::Migration[6.1]
  def change
    add_column :group_users, :group_admin, :boolean, default: false
  end
end
