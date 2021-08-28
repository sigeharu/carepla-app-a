class AddColumnToApplies < ActiveRecord::Migration[6.1]
  def change
    add_column :applies, :user_name, :string
    add_column :applies, :for_user, :integer
  end
end
