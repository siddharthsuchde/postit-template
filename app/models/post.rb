class Post < ActiveRecord::Base
  include Voteable
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  before_save :generate_slug
  
  

  def to_param
    generate_slug
  end
  
  def generate_slug
    self.slug = self.title.gsub(' ', '-').downcase
  end
  
  
end



