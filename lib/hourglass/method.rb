module Hourglass
  class Method
    attr_reader :name

    def initialize(expression)
      @name = expression[1] if expression.method_definition?
      @name = expression.attribute_name if expression.attribute_reader? || expression.attribute_writer?
      @is_attribute = expression.attribute_reader? || expression.attribute_writer?
    end

    def attribute?
      @is_attribute
    end

    def self.from_expression(expression)
      return [Method.new(expression)] unless expression.attribute_accessor?

      literal_exp = Sexp.from_array([:lit, expression[3][1]])
      writer_sexp = Sexp.from_array([:call, nil, :attr_writer, literal_exp])
      reader_sexp = Sexp.from_array([:call, nil, :attr_reader, literal_exp])

      [Method.new(reader_sexp), Method.new(writer_sexp)]
    end
  end
end