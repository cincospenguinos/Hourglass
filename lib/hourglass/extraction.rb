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
        @methods ||= extract_declarations
      end

      def expressions_to_explore
        @expressions_to_explore ||= extract_expressions_to_explore
      end

      private

      def extract_declarations
        methods = []

        expression.each do |exp|
          next unless exp.is_a?(Sexp)

          methods << Method.from_expression(exp)
        end

        methods.flatten
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

    def collect_methods
      collection = MethodCollection.new(expression)
      methods = collection.methods

      collection.expressions_to_explore.each do |index|
        method_calls_in(expression[index]).each do |contents|
          name = contents[2]

          if (used_method_index = methods.map(&:name).index(name))
            @used << methods[used_method_index]
          end
        end
      end

      @unused = methods - @unused
    end

    def method_calls_in(exp)
      exp.select { |e| e.is_a?(Sexp) && (e.method_call? || e.attrasgn?) }
    end
  end
end