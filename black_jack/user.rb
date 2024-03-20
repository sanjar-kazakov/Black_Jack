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

  def player_turn(deck)
    player_choice = gets.chomp.to_i
    case player_choice
    when 1 then skip
    when 2 then take_a_card(deck)
      show_hand
    when 3 then winner_check
    end
  end

  def dealer_turn(deck)
    puts "\n \u2660 Dealer turn \u2660"
    if value >= 17
      puts "  ..."
      sleep(1)
      puts "\n- Dealer skipped a turn."
      skip
    else
      puts "  ..."
      sleep(1)
      take_a_card(deck)
      puts "\n- Dealer added a card."
      sleep(1)
    end
  end
end
