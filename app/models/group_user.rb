class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :partner
end
