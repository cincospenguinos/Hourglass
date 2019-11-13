# frozen_string_literal: true

class SimpleClass
  attr_reader :read_me
  attr_writer :write_me
  attr_accessor :access_me

  def a_public_method
    a_private_method
  end

  private

  def a_private_method
    self.access_me = 'hey'
  end
end
