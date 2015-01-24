require 'spec_helper'
describe Knowtify::Config do

  describe '#api_key' do

    context "default to ENV['KNOWTIFY_API_TOKEN']" do

      it "should work" do
        ENV['KNOWTIFY_API_TOKEN'] ||= "TEST API KEY"
        config = Knowtify::Config.new
        expect(config.api_key).to eql(ENV['KNOWTIFY_API_TOKEN'])
      end

    end
    
  end

  describe '#handler' do

    it {expect(Knowtify::Config.new.handler).to eql(Knowtify::ExconHandler)}

  end

end
