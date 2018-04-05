class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :annoucements
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end



  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(['lower(username) = :value OR lower(email) = :value', {value: login.strip.downcase}]).first
  end
end
