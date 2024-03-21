require_relative 'deck'
require_relative 'helper'

class User
  include Help

  attr_accessor :balance, :value, :hand
  attr_reader :name

  def initialize
    @balance = 100
    @hand = []
    @value = 0
  end

  def show_balance
    @balance
  end

  def hand_value
    puts "\n- value: #{@value}"
  end

  def take_a_card(deck)
    deck.deal(1, self)

    aces_count = @hand.count { |card| card.face == 'A' }

    while @value > 21 && aces_count > 0
      @value -= 10
      aces_count -= 1
    end
  end

   def skip
    true
   end

  def enroll_money
    @balance += 10
  end

  def subtract_money
    @balance -= 10
  end

  def show_hand
    print "- hand: "
    @hand.each do |hand|
      print "#{hand.face}#{hand.suit} "
    end
    hand_value
    puts "\n"
  end
end
