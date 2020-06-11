require 'acceptance_helper'

resource 'Exercise', acceptance: true do
  let!(:user) { create(:user) }
  let!(:exercises) { create_list(:exercise, 10, user_id: user.id) }
  before do
    header 'Content-Type', 'application/json'
    header 'Authorization', token_generator(user.id)
    user.update(admin: true)
  end

  get '/exercises' do
    example_request 'Listing exercises' do
      explanation 'List all the exercises in the system no authentication is needed'
      expect(status).to eq 200
    end
  end

  get '/exercises/:id' do
    route_summary 'This is used to display info from an specific exercise.'
    explanation 'Shows an specific exercise no authentication is needed'

    let(:id) { exercises.first.id }
    example_request 'Getting a specific exercise' do
      expect(status).to eq(200)
    end
  end

  post '/exercises' do
    route_summary 'This is used to create exercises.'
    explanation 'Creates a new exercise requires an admin user to be logged in'

    parameter :name, 'Exercise name'
    parameter :user_id, 'Admin User id'

    example_request 'Creating a new exercise' do
      do_request(name: 'Squats', user_id: user.id.to_s)
      expect(status).to eq(201)
    end
  end

  put '/exercises/:id' do
    route_summary 'This is used to update exercises.'
    explanation 'Updates a new exercise requires an admin user to be logged in'
    let(:id) { exercises.first.id }

    parameter :name, 'Exercise name'
    parameter :user_id, 'Admin User id'

    example_request 'Updating an specific exercise' do
      do_request(name: 'Push-ups', user_id: user.id.to_s)
      expect(status).to eq(204)
    end
  end
end
