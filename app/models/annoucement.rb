class Annoucement < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :exp_date
end
