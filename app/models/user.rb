class User < ApplicationRecord
    # encrypt password
    has_secure_password
    
    # model association
    has_many :exercises
    has_many :measurements, dependent: :destroy

    # validations
    validates_presence_of :name, :email, :password_digest
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX }
end
