$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'specstat/reporter'
require 'webmock/rspec'
require 'pry'

WebMock.enable!
WebMock.disable_net_connect!

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  config.after(:each) do
    Specstat::Reporter.api_token = nil
    ENV['SPECSTAT_API_TOKEN'] = nil
    ENV['SPECSTAT_ENDPOINT'] = nil
  end

end
