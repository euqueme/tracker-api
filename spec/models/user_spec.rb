require 'rails_helper'

# Unit Test for the User model
RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the Exercise model
  it { is_expected.to have_many(:exercises) }
  it { is_expected.to have_many(:measurements).dependent(:destroy) }
  # Validation tests
  # ensure columns name, email, password_digest and remember_digest are present before saving
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password_digest) }

  # ensure email has a valid format
  describe 'email' do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      it { is_expected.to allow_value(valid_address).for(:email) }
    end

    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      it { is_expected.not_to allow_value(invalid_address).for(:email) }
    end
  end
end
