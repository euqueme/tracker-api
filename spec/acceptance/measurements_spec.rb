require 'acceptance_helper'

resource "Measurement", acceptance: true do
  let!(:user) { create(:user) }
  let!(:exercise) { create(:exercise, user_id: user.id) }
  let!(:measurements) { create_list(:measurement, 20, exercise_id: exercise.id, user_id: user.id) }
  before do
    header 'Authorization', token_generator(user.id)
    header 'Content-Type', 'application/json'
  end

  get "/users/:user_id/measurements" do
    let(:user_id) { user.id }
    example_request "Listing Measurements" do
      explanation "List all the measurements from the login user"
      expect(status).to eq 200
    end
  end

  get "/users/:user_id/measurements/:id" do
    let(:user_id) { user.id }
    let(:id) { measurements.first.id }
    example_request "Getting a specific measurement from the login user" do
      expect(status).to eq(200)
    end
  end
end