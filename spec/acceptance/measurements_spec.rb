require 'acceptance_helper'

resource 'Measurement', acceptance: true do
  let!(:user) { create(:user) }
  let!(:exercise) { create(:exercise, user_id: user.id) }
  let!(:measurements) { create_list(:measurement, 20, exercise_id: exercise.id, user_id: user.id) }
  before do
    header 'Authorization', token_generator(user.id)
    header 'Content-Type', 'application/json'
  end

  get '/users/:user_id/measurements' do
    let(:user_id) { user.id }
    example_request 'Listing measurements' do
      explanation 'List all the measurements from the login user'
      expect(status).to eq 200
    end
  end

  get '/users/:user_id/measurements/:id' do
    let(:user_id) { user.id }
    let(:id) { measurements.first.id }
    example_request 'Getting a specific measurement from the login user' do
      explanation 'Shows a specific measurement from the login user'
      expect(status).to eq(200)
    end
  end

  post '/users/:user_id/measurements' do
    route_summary 'This is used to create user measurements.'
    explanation 'Registers a new measurement from the login user'
    let(:user_id) { user.id }

    parameter :description, 'Measurement description'
    parameter :amount, 'Amount of exercise done by the user'
    parameter :user_id, 'Login User'
    parameter :exercise_id, 'Exercise done by the user'

    example_request 'Creating a new user measurement' do
      do_request(description: 'Repetitions', amount: '12', user_id: user.id.to_s, exercise_id: exercise.id.to_s)
      expect(status).to eq(201)
    end
  end

  put '/users/:user_id/measurements/:id' do
    route_summary 'This is used to update user measurements.'
    explanation 'Edits a measurement from the login user'
    let(:user_id) { user.id }
    let(:id) { measurements.first.id }

    parameter :description, 'Measurement description'
    parameter :amount, 'Amount of exercise done by the user'
    parameter :user_id, 'Login User'
    parameter :exercise_id, 'Exercise done by the user'

    example_request 'Updating an specific user measurement' do
      do_request(description: 'Seconds', amount: '60', user_id: user.id.to_s, exercise_id: exercise.id.to_s)
      expect(status).to eq(204)
    end
  end
end
