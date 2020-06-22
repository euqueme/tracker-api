require 'swagger_helper'

describe 'Authentication API' do
  path '/signup' do
    post 'Creates an user' do
      tags 'Signup'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: [ 'name', 'email', 'password', 'password_confirmation' ]
      }

      response '201', 'New User registered in the database' do
        let(:user) { create(:user) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/login' do
    post 'Used to login users' do
      tags 'Login'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }
      
      response '200', 'Logs in an user and creates a new token' do
        run_test!
      end

      response '401', 'invalid credentials' do
        run_test!
      end
    end
  end
end
