class Exercise < ApplicationRecord
  # model association
  belongs_to :user
  has_many :measurements

  # validations
  validates_presence_of :name
end
