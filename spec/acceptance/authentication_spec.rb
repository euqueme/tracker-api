require 'acceptance_helper'

resource "Authentication", acceptance: true do
  let!(:user) { create(:user) }
  before do
    header 'Content-Type', 'application/json'
  end

  post '/signup' do
    route_summary "This is used to create users."
    
    parameter :name, 'User name'
    parameter :email, 'User email'
    parameter :password, 'User password'
    parameter :password_confirmation, 'User password confirmation'
    
    example_request "Creating a new  User" do
      do_request(name: 'Maru', email: 'euqueme@gmail.com', password: 'foobar', password_confirmation: 'foobar')
      expect(status).to eq(201)
    end
  end

  post '/login' do
    route_summary "This is used to login users."
    
    parameter :email, 'User email'
    parameter :password, 'User password'
    
    example_request "Creating a new token" do
      do_request(email: user.email, password: user.password)
      expect(status).to eq(200)
    end
  end


end