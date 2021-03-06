# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :group_users, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :partners, through: :group_users
  has_many :approval_users, dependent: :destroy
  has_many :partner_approvals, through: :approval_users
  has_many :diary
  has_many :schedules
end
