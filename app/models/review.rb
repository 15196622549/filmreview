class Review < ApplicationRecord
  belongs_to :User
  belongs_to :movie
end
