require 'rails_helper'

# Unit test for the Exercise model
RSpec.describe Exercise, type: :model do
  # Association test
  # ensure Exercise model has a 1:m relationship with the Measurement model
  it { should have_many(:measurements).dependent(:destroy) }
  # Validation tests
  # ensure that the name column is present before saving
  it { should validate_presence_of(:name) }
end