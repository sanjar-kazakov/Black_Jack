require_relative 'card'

class Deck
  attr_reader :cards, :faces, :suits
  def initialize
    @faces = [*(2..10), "A", "K", "Q", "J"]
    @suits = ["\u2665", "\u2666", "\u2663", "\u2660"]
    @cards = []

    generate_deck
  end

  def generate_deck
    @faces.each do |face|
      if face.class == Integer
        value = face
      elsif
        face == "A"
        value = 11
      else
        value = 10
      end

      @suits.each do |suit|
        @cards << Card.new(face, suit, value)
      end
    end
    @cards.shuffle!
  end

  def deal(num, user)
    num.times {(@cards.shift.generate_card(user))}
  end
end
