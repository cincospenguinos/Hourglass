require 'spec_helper'

describe Hourglass::Extraction do
  let(:simple_extraction) {
    file = File.open('spec/fixtures/simple_class.rb').read
    expression = RubyParser.new.parse(file)
    Hourglass::Extraction.new(expression)
  }

  it 'attaches the correct class to each method' do
    extraction = simple_extraction
    (extraction.used_methods + extraction.unused_methods).each do |method|
      expect(method.class_name).to eq('SimpleClass')
    end
  end

  describe '#used_methods' do
    it 'contains methods used in a single class' do
      used = %i[a_private_method access_me=]
      expect(simple_extraction.used_methods.map(&:name)).to eq(used)
    end
  end

  describe '#unused_methods' do
    it 'contains methods not used in a single class' do
      unused = %i[read_me write_me= access_me a_public_method]
      expect(simple_extraction.unused_methods.map(&:name)).to eq(unused)
    end
  end
end
