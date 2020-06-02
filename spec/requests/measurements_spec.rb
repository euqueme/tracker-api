require 'rails_helper'

RSpec.describe 'Measurements API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:exercise) { create(:exercise, user_id: user.id) }
  let!(:measurements) { create_list(:measurement, 20, exercise_id: exercise.id, user_id: user.id) }
  let(:exercise_id) { exercise.id }
  let(:id) { measurements.first.id }

  # Test suite for GET /exercises/:exercise_id/measurements
  describe 'GET /exercises/:exercise_id/measurements' do
    before { get "/exercises/#{exercise_id}/measurements" }

    context 'when exercise exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all exercise measurements' do
        expect(json.size).to eq(20)
      end
    end

    context 'when exercise does not exist' do
      let(:exercise_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Exercise/)
      end
    end
  end

  # Test suite for GET /exercises/:exercise_id/measurements/:id
  describe 'GET /exercises/:exercise_id/measurements/:id' do
    before { get "/exercises/#{exercise_id}/measurements/#{id}" }

    context 'when exercise measurement exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the measurement' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when exercise measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Measurement/)
      end
    end
  end

  # Test suite for PUT /exercises/:exercise_id/measurements
  describe 'POST /exercises/:exercise_id/measurements' do
    let(:valid_attributes) { { description: 'Repetitions', amount: 10, exercise_id: exercise.id, user_id: user.id } }

    context 'when request attributes are valid' do
      before { post "/exercises/#{exercise_id}/measurements", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/exercises/#{exercise_id}/measurements", params: {amount: 10, exercise_id: exercise.id, user_id: user.id} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /exercises/:exercise_id/measurements/:id
  describe 'PUT /exercises/:exercise_id/measurements/:id' do
    let(:valid_attributes) { { description: 'Seconds', amount: 75, exercise_id: exercise.id, user_id: user.id } }

    before { put "/exercises/#{exercise_id}/measurements/#{id}", params: valid_attributes }

    context 'when measurement exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the measurement' do
        updated_measurement = Measurement.find(id)
        expect(updated_measurement.description).to match(/Seconds/)
      end
    end

    context 'when the measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Measurement/)
      end
    end
  end

  # Test suite for DELETE /exercises/:id
  describe 'DELETE /exercises/:id' do
    before { delete "/exercises/#{exercise_id}/measurements/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end