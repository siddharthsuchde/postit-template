class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validate :password, presence: true, length: {minimum: 3}
end


