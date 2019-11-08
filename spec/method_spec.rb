require 'spec_helper'

describe Hourglass::Method do
  context 'when handed a method definition' do
    it 'extracts a name out of a symbolic expression' do
      exp = Sexp.from_array(%i[defn some_method])
      method = Hourglass::Method.new(exp)
      expect(method.name).to eq(:some_method)
    end
  end
end