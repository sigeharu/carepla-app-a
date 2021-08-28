class PartnerApproval < ApplicationRecord
  has_many :apploval_users, dependent: :destroy
  has_many :users, through: :approval_users
end
