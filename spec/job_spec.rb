require_relative '../lib/remote_jobs'
require_relative '../lib/job_app'
require_relative '../lib/scrapper'

describe JobApp do
  let(:app) { JobApp.new('testing') }

  describe '#JobApp.new' do
    it 'Test a complete search of jobs for one language' do
      expect(app.debug_message).to eq('Thank you for using Job App')
    end
  end
end

describe RemoteJobs do
  let(:jobs_success) { RemoteJobs.new('ruby') }
  let(:jobs_exception) { RemoteJobs.new('exception') }

  describe '#RemoteJobs.new' do
    it 'Tests a single sucessful language search' do
      expect(jobs_success.debug_message).to eq('Search complete')
    end

    it 'Tests a single language search that throws an exception' do
      expect(jobs_exception.debug_message).to eq('Exception catched')
    end
  end
end

describe Scrapper do
  describe '#parsing' do
    it 'Test if the output from the module Scrapper is a Nokogiri object' do
      class Scrapper_debug
        attr_reader :debug
        include Scrapper
        def initialize
          @debug = parsing('ruby')
        end
      end
      test_module = Scrapper_debug.new
      expect(test_module.debug).to be_an_instance_of(Nokogiri::HTML::Document)
    end
  end
end