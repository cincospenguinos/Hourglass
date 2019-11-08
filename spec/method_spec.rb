require 'spec_helper'

describe Hourglass::Method do
  context 'when handed a method definition' do
    it 'extracts a name out of a symbolic expression' do
      exp = Sexp.from_array(%i[defn some_method])
      method = Hourglass::Method.new(exp)
      expect(method.name).to eq(:some_method)
    end

    it 'is not an attribute' do
      exp = Sexp.from_array(%i[defn some_method])
      method = Hourglass::Method.new(exp)
      expect(method.attribute?).to be_falsey
    end
  end

  context 'when provided an attribute definition' do
    it 'properly gathers a reader type' do
      lit =  Sexp.from_array(%i[lit reader_attribute])
      exp = Sexp.from_array([:call, nil, :attr_reader,lit])
      method = Hourglass::Method.new(exp)
      expect(method.name).to eq(:reader_attribute)
    end

    it 'properly gathers a writer type' do
      exp = Sexp.from_array([:call, nil, :attr_writer, Sexp.from_array(%i(lit writer_attr))])
      method = Hourglass::Method.new(exp)
      expect(method.name).to eq(:writer_attr=)
    end

    it 'indicates that it is an attribute' do
      lit = Sexp.from_array(%i[lit something])
      exp = Sexp.from_array([:call, nil, :attr_reader, lit])
      method = Hourglass::Method.new(exp)
      expect(method.attribute?).to be_truthy
    end
  end

  describe 'from_expression' do
    it 'returns a reader method and a writer method given attr_accessor' do
      exp = Sexp.from_array([:call, nil, :attr_accessor, Sexp.from_array(%i(lit accessor_attr))])
      method = Hourglass::Method.from_expression(exp)
      expect(method.length).to eq(2)
      expect(method[0].name).to eq(:accessor_attr)
      expect(method[1].name).to eq(:accessor_attr=)
    end
  end
end