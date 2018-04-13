class Annoucement < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :delete_all
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :exp_date
end
