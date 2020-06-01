class Measurement < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
end
