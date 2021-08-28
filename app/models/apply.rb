class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :partner
  validates :user_id, presence: true
  validates :partner_id, presence: true
  validates :user_id, uniqueness: { scope: :partner_id }
  validates :partner_id, uniqueness: { scope: :user_id }
end
