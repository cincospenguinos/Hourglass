module Hourglass
  class Method
    # :call nil :attr_reader Sexp
    # :call nil :attr_writer Sexp
    # :call nil :attr_accessor Sexp
    # :defn a_public_method *
    # :call nil :private

    attr_reader :name

    def initialize(expression)
      @name = expression[1] if expression.method_definition?
      @name = expression[3][1] if expression.attribute_reader?
    end
  end
end