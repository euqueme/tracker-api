require 'rails_helper'

# Unit test for the Exercise model
RSpec.describe Exercise, type: :model do
  # Association test
  # ensure Exercise model has a 1:m relationship with the Measurement model
  it { is_expected.to have_many(:measurements) }
  # Validation tests
  # ensure that the name column is present before saving
  it { is_expected.to validate_presence_of(:name) }
end
