require 'rails_helper'

RSpec.describe 'Measurements API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:exercise) { create(:exercise, user_id: user.id) }
  let!(:measurements) { create_list(:measurement, 20, exercise_id: exercise.id, user_id: user.id) }
  let(:exercise_id) { exercise.id }
  let(:user_id) { user.id }
  let(:id) { measurements.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /users/user_id/measurements
  describe 'GET /users/:user_id/measurements' do
    before { get "/users/#{user_id}/measurements", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all users measurements' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/measurements/:id
  describe 'GET /users/:user_id/measurements/:id' do
    before { get "/users/#{user_id}/measurements/#{id}", params: {}, headers: headers }

    context 'when user measurement exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the measurement' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Measurement/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/measurements
  describe 'POST /users/:user_id/measurements' do
    let(:valid_attributes) { { description: 'Repetitions', amount: 10, exercise_id: exercise.id, user_id: user.id }.to_json }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/measurements", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/measurements", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Exercise must exist, Description can't be blank, Amount can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/measurements/:id
  describe 'PUT /users/:user_id/measurements/:id' do
    let(:valid_attributes) { { description: 'Seconds', amount: 75, exercise_id: exercise.id, user_id: user.id }.to_json }

    before { put "/users/#{user_id}/measurements/#{id}", params: valid_attributes, headers: headers }

    context 'when measurement exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'updates the measurement' do
        updated_measurement = Measurement.find(id)
        expect(updated_measurement.description).to match(/Seconds/)
      end
    end

    context 'when the measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Measurement/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/measurements/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
