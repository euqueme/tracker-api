require 'swagger_helper'
# rubocop:disable RSpec/EmptyExampleGroup
# rubocop:disable RSpec/DescribeClass
describe 'Authentication API' do
  path '/v1/signup' do
    post 'Creates an user' do
      tags 'Signup'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_digest: { type: :string }
        },
        required: %w[name email password password_digest]
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

  path '/v1/login' do
    post 'Used to login users' do
      tags 'Login'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'Logs in an user and creates a new token' do
        let(:fuser) { create(:user) }
        let(:user) { { email: fuser.email, password: fuser.password } }
        run_test!
      end

      response '401', 'invalid credentials' do
        run_test!
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
# rubocop:enable RSpec/DescribeClass
