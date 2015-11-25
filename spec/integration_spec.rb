require 'spec_helper'

describe 'running the Specstat agent within a test suite' do

  let(:spec_file) { Tempfile.open(['specstat_spec', '.rb']) }

  before do
    spec_file.write <<-EOF
      describe 'An example' do
        it 'is passing' do
          expect(true).to be(true)
        end

        it 'is failing' do
          expect(true).to be(false)
        end

        it 'is pending'
      end
    EOF
    spec_file.close
  end

  after(:each) do
    spec_file.unlink
  end

  it 'runs with an example file' do
    cmd = "rspec -I #{File.expand_path('../../lib', __FILE__)} -r specstat/rspec #{spec_file.path}"
    result = `#{cmd}`
    expect(result).to include('Initializing Specstat...')
    expect(result).to include('Sending 2 results to Specstat...')
  end

end
