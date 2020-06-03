require 'acceptance_helper'

resource "Exercise", acceptance: true do
  let!(:user) { create(:user) }
  let!(:exercises) { create_list(:exercise, 10, user_id: user.id) }
  before do
    header 'Content-Type', 'application/json'
  end

  get "/exercises" do
    example_request "Listing Exercises" do
      explanation "List all the exercises in the system"
      expect(status).to eq 200
    end
  end

  get "/exercises/:id" do
    let(:id) { exercises.first.id }
    example_request "Getting a specific exercise" do
      expect(status).to eq(200)
    end
  end
end