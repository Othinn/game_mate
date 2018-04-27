class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :announcement
  validates_presence_of :content
end
