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
      method_definitions = []
      methods_to_explore = []
      expression.each_with_index do |exp, index|
        next unless exp.is_a?(Sexp)
        # :call nil :attr_reader Sexp
        # :call nil :attr_writer Sexp
        # :call nil :attr_accessor Sexp
        # :defn a_public_method *
        # :call nil :private
        if exp[0] == :defn
          method_definitions << Method.new(exp)
          methods_to_explore << index
        # elsif exp[0] == :call && exp[2].to_s.include?('attr')
        #   method_definitions << Method.new(exp[3][1])
        end
      end

      used_methods = []

      methods_to_explore.each do |index|
        method = expression[index]

        method.select { |m| m.is_a?(Sexp) }.each do |contents|
          next unless contents[0] == :call

          if (index = method_definitions.map(&:name).index(contents[2]))
            used_methods << method_definitions[index]
          end
        end
      end

      @used = used_methods
      @unused = method_definitions - used_methods
    end
  end
end