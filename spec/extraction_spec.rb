require 'spec_helper'

describe Hourglass::Extraction do
  let(:simple_extraction) {
    file = File.open('spec/fixtures/simple_class.rb').read
    expression = RubyParser.new.parse(file)
    Hourglass::Extraction.new(expression)
  }

  describe '#used_methods' do
    it 'contains methods used in a single class' do
      used = %i[a_private_method access_me=]
      expect(simple_extraction.used_methods).to eq(used)
    end
  end
end