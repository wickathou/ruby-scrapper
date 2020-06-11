require_relative '../lib/scrapper'

describe Scrapper do
  describe '#parsing' do
    it 'Test if the output from the module Scrapper is a Nokogiri object' do
      class ScrapperDebug
        attr_reader :debug
        include Scrapper
        def initialize
          @debug = parsing('ruby')
        end
      end
      test_module = ScrapperDebug.new
      expect(test_module.debug).to be_an_instance_of(Nokogiri::HTML::Document)
    end
  end
end
