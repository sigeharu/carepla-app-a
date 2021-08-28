class ApprovalUser < ApplicationRecord
  belongs_to :user
  belongs_to :partner_approval
end
