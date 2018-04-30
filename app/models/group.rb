class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :announcements, dependent: :destroy
  validates_uniqueness_of :group_name


end
