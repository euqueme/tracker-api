require 'rails_helper'

# Test suite for the Measurement model
RSpec.describe Measurement, type: :model do
  # Association test
  # ensure a Measurement record belongs to a single Excercise record and a single User
  it { should belong_to(:exercise) }
  it { should belong_to(:user) }
  # Validation test
  # ensure description and amount columns are present before saving
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:amount) }
end
