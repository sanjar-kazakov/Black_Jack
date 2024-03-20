require_relative 'user'
require_relative 'helper'

class Player < User
  def initialize(name)
    @name = name
    super()
  end
end
