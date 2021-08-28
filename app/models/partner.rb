class Partner < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :users, through: :group_users

  # ユーザーがコミュニティに所属していればtrueを返す
  def user_group_users?(user)
    users.include?(user)
  end
end
