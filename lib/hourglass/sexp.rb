require 'sexp'

class Sexp
  def method_definition?
    self[0] == :defn
  end

  def method_call?
    self[0] == :call
  end

  def attrassgn?
    self[0] == :attrasgn
  end

  def attribute_reader?
    method_call? && self[2] == :attr_reader
  end

  def attribute_writer?
    method_call? && self[2] == :attr_writer
  end

  def attribute_accessor?
    method_call? && self[2] == :attr_accessor
  end

  def attribute_name
    return self[3][1] if attribute_reader?
    return "#{self[3][1]}=".to_sym if attribute_writer?

    nil
  end
end