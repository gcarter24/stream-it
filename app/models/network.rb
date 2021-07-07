class Network < ApplicationRecord
  has_many :movie_networks
  has_many :movies, through: :movie_networks
end
