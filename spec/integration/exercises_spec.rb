require 'swagger_helper'

describe 'Exercise' do
  path '/exercises' do
    get 'List all exercises' do
      tags 'Exercise'
      consumes 'application/json'

      response '200', 'Shows all exercises no authentication is needed' do
        schema type: :object,
        properties: {
          id: { type: :integer, },
          name: { type: :string },
          user_id: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: [ 'id', 'name' ]

        let!(:exercises) { create_list(:exercise, 10) }
        run_test!
      end
    end
  end

  path '/exercises/{id}' do
    get 'List an specific exercise' do
      tags 'Exercise'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'Shows an specific exercise no authentication is needed' do
        schema type: :object,
        properties: {
          id: { type: :integer, },
          name: { type: :string },
          user_id: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: [ 'id', 'name' ]

      let(:id) { create(:exercise).id }
        run_test!
      end

      response '401', 'invalid credentials' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
