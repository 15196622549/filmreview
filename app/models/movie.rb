class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :title, presence: true

  has_many :movie_favorites
  has_many :members, through: :movie_favorites, source: :user
  
end
