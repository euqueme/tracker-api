class Measurement < ApplicationRecord
  # model association
  belongs_to :user
  belongs_to :exercise

  # validation
  validates_presence_of :description
  validates_presence_of :amount
end
