require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :json
  config.curl_host = 'http://tracker-api' # Will be used in curl request
  config.api_name = "Tracker API" # Your API name
  config.request_headers_to_include = ["Host", "Content-Type"]
  config.response_headers_to_include = ["Host", "Content-Type"]
  #config.curl_headers_to_filter = ["Authorization"] # Remove this if you want to show Auth headers in request
  config.keep_source_order = true
end