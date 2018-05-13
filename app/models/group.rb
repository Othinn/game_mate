class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :announcements, dependent: :destroy
  validates_uniqueness_of :group_name
  validates_presence_of :group_name, :created_by, :group_image
  validates_length_of :group_name, minimum: 5, maximum: 20
  mount_uploader :group_image, GroupImageUploader

  scope :user_in_any_group?, -> (user) {joins(:user_groups).where('user_groups.user_id = ?', user)}

end
