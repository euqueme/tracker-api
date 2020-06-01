class Exercise < ApplicationRecord
  # model association
  belongs_to :user
  has_many :measurements, dependent: :destroy

  # validations
  validates_presence_of :name
end
