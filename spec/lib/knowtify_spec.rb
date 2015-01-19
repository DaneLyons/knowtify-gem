require 'spec_helper'

describe Knowtify do
  describe '#config' do
    it { expect(Knowtify.config).to be_a(Knowtify::Config) }
  end
end
