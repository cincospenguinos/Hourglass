module Services
  class MethodCollection
    attr_reader :expression

    def initialize(expression)
      @expression = expression
    end

    def methods
      @methods ||= extract_declarations
    end

    def expressions_to_explore
      @expressions_to_explore ||= extract_expressions_to_explore
    end

    private

    def extract_declarations
      methods = []

      expression.each do |exp|
        next unless valid_method_declaration?(exp)

        methods << Hourglass::Method.from_expression(exp)
      end

      methods.flatten
    end

    def valid_method_declaration?(expression)
      expression.is_a?(Sexp) && (expression.method_definition? ||
          expression.attribute_reader? || expression.attribute_writer? ||
          expression.attribute_accessor?)
    end

    def extract_expressions_to_explore
      to_explore = []

      expression.each_with_index do |exp, index|
        next unless exp.is_a?(Sexp)

        to_explore << index if exp.method_definition?
      end

      to_explore
    end
  end
end