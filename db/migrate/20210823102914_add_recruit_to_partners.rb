class AddRecruitToPartners < ActiveRecord::Migration[6.1]
  def change
    add_column :partners, :recruit_partner, :boolean, default: :false
  end
end
