class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates_uniqueness_of :user_id, scope: %i[group_id]

end
