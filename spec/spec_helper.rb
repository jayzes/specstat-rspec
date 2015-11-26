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

require 'sinatra/base'
class BackendDummy < Sinatra::Base
  post '/api/v1/raw_test_run' do
    halt 201
  end
end

RSpec.configure do |c|
  c.before(dummy_api: true) do
    @backend_dummy_thread = Thread.new do
      BackendDummy.run!(port: 4567)
    end
  end

  c.after(dummy_api: true) do
    BackendDummy.quit!
    @backend_dummy_thread.join
  end
end
