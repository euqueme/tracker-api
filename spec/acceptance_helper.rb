require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json]
  config.curl_host = 'http://localhost:3000'
  config.api_name = "App API"

  config.define_group :cdn do |config|
    config.docs_dir = Rails.root.join("public", "assets", "api", "cdn")
    config.filter = :cdn
  end

  config.define_group :management do |config|
    config.docs_dir = Rails.root.join("public", "assets", "api", "management")
    config.filter = :management
  end
end