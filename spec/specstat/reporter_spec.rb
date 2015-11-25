require 'spec_helper'

describe Specstat::Reporter do

  it 'has a version number' do
    expect(Specstat::Reporter::VERSION).not_to be nil
  end

  it 'allows setting the api_token via an accessor' do
    Specstat::Reporter.api_token = 'abc123'
    expect(Specstat::Reporter.api_token).to eq('abc123')
  end

  it 'allows setting the api_token via an environment variable' do
    ENV['SPECSTAT_API_TOKEN'] = 'def456'
    expect(Specstat::Reporter.api_token).to eq('def456')
  end

  it 'has a default value for the endpoint' do
    expect(Specstat::Reporter.endpoint).to eq('https://specstat-backend.herokuapp.com')
  end

  it 'allows setting the endpoint via an environment variable' do
    ENV['SPECSTAT_ENDPOINT'] = 'https://www.example.com'
    expect(Specstat::Reporter.endpoint).to eq('https://www.example.com')
  end
end
