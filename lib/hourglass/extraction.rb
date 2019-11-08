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

    def collect_methods
      collection = Services::MethodCollection.new(expression)
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