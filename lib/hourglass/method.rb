module Hourglass
  class Method
    attr_reader :name, :class_name

    def initialize(expression, opts = {})
      @name = expression[1] if expression.method_definition?
      @name = expression.attribute_name if expression.attribute_reader? || expression.attribute_writer?
      @is_attribute = expression.attribute_reader? || expression.attribute_writer?
      @class_name = opts[:class_name] || nil
    end

    def attribute?
      @is_attribute
    end

    def self.from_expression(expression, opts = {})
      return [Method.new(expression, opts)] unless expression.attribute_accessor?

      literal_exp = Sexp.from_array([:lit, expression[3][1]])
      writer_sexp = Sexp.from_array([:call, nil, :attr_writer, literal_exp])
      reader_sexp = Sexp.from_array([:call, nil, :attr_reader, literal_exp])

      [Method.new(reader_sexp, opts), Method.new(writer_sexp, opts)]
    end
  end
end
