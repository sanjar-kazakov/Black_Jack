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
        return
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
      player.player_turn(deck)
      sleep(2)
      dealer.dealer_turn(deck)
      puts "\n - Вскрываемся ..."
      sleep(2)
      winner_check
  end

  # def result_check
  #   winner_check if (player.hand.count == 3) || (dealer.hand == 3)
  # end
end


Engine.new.game_menu
