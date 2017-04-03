class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :movies
 has_many :reviews

 has_many :movie_favorites
 has_many :favorited_movies, :though => :movie_favorites, :source => :movie

end
