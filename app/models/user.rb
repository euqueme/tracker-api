class User < ApplicationRecord
    # model association
    has_many :exercises

    # validations
    validates_presence_of :name, :email, :password_digest, :remember_digest
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX }
end
