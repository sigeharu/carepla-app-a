class AddDetailsToPartners < ActiveRecord::Migration[6.1]
  def change
    add_column :partners, :admin_user, :integer, null: false
  end
end
