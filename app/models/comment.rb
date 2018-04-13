class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :annoucement
  validates_presence_of :content
end
