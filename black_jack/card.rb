require_relative 'user'

class Card
  attr_accessor :face, :suit, :value
  def initialize(face, suit, value)
    @face = face
    @suit = suit
    @value = value
  end

  def generate_card(user)
    new_card = Card.new(face, suit, value)
    user.hand << new_card
    user.value += new_card.value
  end
end
