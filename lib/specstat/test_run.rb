require "specstat/test_result"
require "net/http"
require "json"

module Specstat
  class TestRun
    attr_reader :results

    def initialize
      @results = []
    end

    def add(example)
      result = TestResult.new(example.full_description,
                          example.execution_result.status.to_s,
                          example.execution_result.run_time)
      @results.push(result)
    end

    def submit!
      Specstat::Reporter.logger.info "Sending #{@results.size} results to Specstat..."
      url = URI.parse(Reporter.endpoint)
      url.path = "/api/v1/raw_test_run"
      req = Net::HTTP::Post.new(url.to_s,
                               "Authorization"  => "Bearer #{Reporter.api_token}",
                               "Content-Type"   => "application/json",
                               "Accept"         => "application/json",
                               "User-Agent"     => "Specstat RSpec Reporter #{Reporter::VERSION}")
      req.body = @results.map(&:to_h).to_json
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      res = http.request(req)
      res.code == 201
    end
  end
end
