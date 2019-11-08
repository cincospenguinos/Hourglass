require 'ruby_parser'

module Hourglass
  class Extraction
    attr_reader :expression

    def initialize(symbolic_expression)
      @expression = symbolic_expression
      @used = []
      @unused = []

      collect_methods
    end

    def used_methods
      @used.map(&:name)
    end

    private

    class MethodCollection
      attr_reader :expression

      def initialize(expression)
        @expression = expression
      end

      def methods
        @methods ||= get_declarations
      end

      private

      def get_declarations
        methods = []

        expression.each do |exp|
          next unless exp.is_a?(Sexp)

          methods << Method.from_expression(exp)
        end

        methods.flatten
      end
    end

    def collect_methods
      collection = MethodCollection.new(expression)
      methods = collection.methods
      to_explore = []

      expression.each_with_index do |exp, index|
        next unless exp.is_a?(Sexp)

        to_explore << index if exp.method_definition?
      end

      to_explore.each do |index|
        method = expression[index]
        calls_in_method = method.select { |e| e.is_a?(Sexp) && (e.method_call? || e[0] == :attrasgn) }

        calls_in_method.each do |contents|
          name = contents[2]

          if (used_method_index = methods.map(&:name).index(name))
            @used << methods[used_method_index]
          end
        end
      end

      @unused = methods - @unused
    end
  end
end