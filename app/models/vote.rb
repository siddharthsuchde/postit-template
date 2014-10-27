class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true
  # scope is a condition that places a restriction
  # e.g. a user can vote on a NEW post or comment if he hasn't already
  # hence the restriction is that for the same comment or post he can't vote
  # hence scope is voteable
  validates :user, uniqueness: {scope: :voteable, message: "Cannot Vote More than Once"}
end

