require 'pry'
require_relative 'user'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'helper'

class Engine

include Help

  attr_accessor :player, :dealer, :deck

  def initialize
    print "Enter your name: "
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new
  end

  def game_menu
    loop do
      display_choice
      user_choice = gets.chomp.to_i
      case user_choice
      when 1
        new_game
        run
      when 2
        exit
      end
    end
  end

  def new_game
    clear_data
    @deck = Deck.new
    deck.deal(2, player)
    deck.deal(2, dealer)
  end

  def clear_data
    player.hand.clear
    dealer.hand.clear
    player.value = 0
    dealer.value = 0
    # player.balance = 100
    # dealer.balance = 100
  end

  def run
      game_flow
      player_turn(deck)
      sleep(2)
      dealer_turn(deck)
      puts "\n - Вскрываемся ..."
      sleep(2)
      winner_check
  end

  def player_turn(deck)
    player_choice = gets.chomp.to_i
    case player_choice
    when 1 then player.skip
    when 2 then player.take_a_card(deck)
      player.show_hand
    when 3 then winner_check
    end
  end

  def dealer_turn(deck)
    puts "\n \u2660 Dealer turn \u2660"
    if dealer.value >= 17
      puts "  ..."
      sleep(1)
      puts "\n- Dealer skipped a turn."
      dealer.skip
    else
      puts "  ..."
      sleep(1)
      dealer.take_a_card(deck)
      puts "\n- Dealer added a card."
      sleep(1)
    end
  end

  def winner_check
    if dealer.value > player.value && dealer.value <= MAX_VALUE
       dealer_won
    elsif
      dealer.value > MAX_VALUE && player.value <= MAX_VALUE
      player_won
    elsif
      player.value > dealer.value && player.value <= MAX_VALUE
      player_won
    elsif
      player.value > MAX_VALUE && dealer.value <= MAX_VALUE
      dealer_won
    else
      puts "\n ---Draw!---"
      open_hands
    end
    game_menu
  end
end


Engine.new.game_menu
