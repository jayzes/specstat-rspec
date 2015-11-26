require "specstat/reporter"
require "rspec"

Specstat::Reporter.logger.info 'Initializing Specstat...'

begin
  require "vcr"
  VCR.configure do |c|
    c.ignore_hosts URI.parse(Specstat::Reporter.endpoint).host
  end
rescue LoadError
  # No-op
end

class SpecstatFormatter
  RSpec::Core::Formatters.register self,
    :example_passed,
    :example_pending,
    :example_failed

  def initialize(out)
    @out = out
  end

  def example_finished(notification)
    example = notification.example
    Specstat::Reporter.current_run.add(example)
  end
  alias example_passed example_finished
  alias example_pending example_finished
  alias example_failed example_finished
end

RSpec.configure do |c|
  c.add_formatter SpecstatFormatter
end

at_exit do
  Specstat::Reporter.current_run.submit!
end
