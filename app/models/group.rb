class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :annoucements, dependent: :delete_all
  validates_uniqueness_of :group_name


end
