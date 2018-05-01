class Announcement < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :delete_all
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :exp_date
  validate :exp_date_cannot_be_in_the_past

  scope :user_in_any_group?, -> (user) {where('user_groups.user_id = ?', user)}

  private

  def exp_date_cannot_be_in_the_past
    if exp_date.present? && exp_date < Date.today
      errors.all(:exp_date, 'can\'t be in the past')
    end
  end
end
