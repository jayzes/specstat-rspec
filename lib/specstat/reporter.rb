require "specstat/reporter/version"
require "specstat/test_run"
require "logger"

module Specstat
  module Reporter

    ENDPOINT = "https://specstat-backend.herokuapp.com"

    class << self

      def api_token=(value)
        @api_token = value
      end

      def api_token
        @api_token || ENV["SPECSTAT_API_TOKEN"]
      end

      def endpoint
        ENV["SPECSTAT_ENDPOINT"] || ENDPOINT
      end

      def current_run
        @current_run ||= Specstat::TestRun.new
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def logger=(value)
        @logger = value
      end

    end
  end
end
