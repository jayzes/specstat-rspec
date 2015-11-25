require 'spec_helper'
require 'specstat/test_run'

describe Specstat::TestRun do

  let(:execution_result) do
    instance_double('RSpec::Core::Example::ExecutionResult',
                    status: :passed,
                    run_time: 1.23)
  end

  let(:example) do
    instance_double('RSpec::Core::Example',
                    full_description: 'Specstat::Reporter has a version number',
                    execution_result: execution_result)
  end

  describe '#add' do
    it 'adds the specified example to the list of results to send' do
      subject.add(example)
      expect(subject.results.last.status).to eq('passed')
      expect(subject.results.last.name).to eq('Specstat::Reporter has a version number')
      expect(subject.results.last.run_time).to eq(1.23)
    end
  end

  describe '#submit!' do
    let!(:stub) do
      stub_request(:post, 'https://specstat-backend.herokuapp.com/api/v1/test_run').
        with(
          body: "[{\"name\":\"Specstat::Reporter has a version number\",\"status\":\"passed\",\"run_time\":1.23}]",
          headers: {
            "Content-Type" => "application/json",
            "Accept" => "application/json",
            "User-Agent" => "Specstat RSpec Reporter 0.1.0",
            "Authorization" => "Bearer abc123"
          }).
        to_return(status: 201)
    end

    it 'sends a request to the backend service' do
      Specstat::Reporter.api_token = 'abc123'
      subject.add(example)
      subject.submit!
      expect(stub).to have_been_requested
    end
  end

end
