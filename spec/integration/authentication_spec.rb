require 'swagger_helper'

describe 'Authentication API' do
  # let!(:user) { create(:user) }
  # before do
  #   header 'Content-Type', 'application/json'
  # end

  # post '/signup' do
  #   route_summary 'This is used to create users.'
    
  #   parameter :name, 'User name'
  #   parameter :email, 'User email'
  #   parameter :password, 'User password'
  #   parameter :password_confirmation, 'User password confirmation'

  #   example_request 'Creating a new  User' do
  #     explanation 'Registers a new user in the database'
  #     do_request(name: 'Maru', email: 'euqueme@gmail.com', password: 'foobar', password_confirmation: 'foobar')
  #     expect(status).to eq(201)
  #   end
  # end


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

  # post '/login' do
  #   route_summary 'This is used to login users.'
    
  #   parameter :email, 'User email'
  #   parameter :password, 'User password'

  #   example_request 'Creating a new token' do
  #     explanation 'Logs in a registered user.'
  #     do_request(email: user.email, password: user.password)
  #     expect(status).to eq(200)
  #   end
  # end
end
