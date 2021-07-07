class MovieNetwork < ApplicationRecord
  belongs_to :movie
  belongs_to :network
end
