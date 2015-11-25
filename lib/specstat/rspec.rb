require "specstat/reporter"
require "rspec"

Specstat::Reporter.logger.info 'Initializing Specstat...'

RSpec.configure do |c|
  c.around(:each) do |example|
    example.run
    Specstat::Reporter.current_run.add(example)
  end
  c.after(:all) do
    Specstat::Reporter.current_run.submit!
  end
end
