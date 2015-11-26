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

RSpec.configure do |c|
  c.around(:each) do |example|
    example.run
    Specstat::Reporter.current_run.add(example)
  end
  c.after(:all) do
    Specstat::Reporter.current_run.submit!
  end
end
