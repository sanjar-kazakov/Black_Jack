# require 'pry'; binding.pry


class User
  attr_accessor :balance, :value, :hand
  attr_reader :name
  def initialize
    @balance = 100
    @hand = []
    @value = 0
  end

  def take_a_card(deck)
    deck.deal(1, self)
    show_hand
  end

   def skip
    true
   end

  def show_balance
    @balance
  end

  def show_hand
    print "Your hand: "
    @hand.each do |hand|
      print "#{hand.face}#{hand.suit} "
    end
    hand_value
  end

  def hand_value
    puts "\nValue: #{@value}"
  end

  def enroll_money
    @balance += 10
  end

  def subtract_money
    @balance -= 10
  end
end


class Player < User
  def initialize(name)
    @name = name
    super()
  end
end


class Dealer < User
end


class Engine
  MAX_VALUE = 21
  MAX_HAND = 3

  CHOICE = ["Пропустить", "Добавить карту", "Открыть карты"]

  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new("Anton")
    @dealer = Dealer.new
    @deck = Deck.new
    deck.deal(2, player)
    deck.deal(2, dealer)
  end

  def run
    loop do
      display_choice
      player_turn
      dealer_turn
      break if result_check
    end
  end

  def display_choice
    player.show_hand
    puts "\n  Ваш ход:"
    CHOICE.each_with_index {|choice, i| puts "#{i + 1}: #{choice}"}
  end

  def player_turn
    player_choice = gets.chomp.to_i
    case player_choice
    when 1
      player.skip
    when 2
      player.take_a_card(deck)
    when 3
      player.show_hand
    end
  end

  def dealer_turn
    puts "\n  Ходит Дилер:"
    if dealer.value >= 17
      dealer.skip
    else
      dealer.take_a_card(deck)
    end
  end

  def result_check
    player.hand.count == 3
  end

  def winner_check
    if dealer.value > player.value && dealer.value <= 21
      dealer.enroll_money
      player.subtract_money
      puts "Dealer won!"
    elsif
      player.value > dealer.value && player.value <= 21
      player.enroll_money
      dealer.subtract_money
      puts "Player won!"
    else
      puts "Draw!"
    end
  end
end


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

game = Engine.new
# player = Player.new("Anton")
# dealer = Dealer.new
# deck = Deck.new
# deck.deal(2, player)
# deck.deal(2, dealer)
# player.actual_hand
# deck.cards
