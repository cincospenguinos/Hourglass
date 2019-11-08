require 'spec_helper'

describe Hourglass::Method do
  context 'when handed a method definition' do
    it 'extracts a name out of a symbolic expression' do
      exp = Sexp.from_array(%i[defn some_method])
      method = Hourglass::Method.new(exp)
      expect(method.name).to eq(:some_method)
    end
  end

  context 'when provided an attribute definition' do
    it 'properly gathers a reader type' do
      exp = Sexp.from_array([:call, nil, :attr_reader, Sexp.from_array(%i(lit reader_attribute))])
      method = Hourglass::Method.new(exp)
      expect(method.name).to eq(:reader_attribute)
    end
  end
end