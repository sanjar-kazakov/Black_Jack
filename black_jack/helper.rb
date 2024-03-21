module Help

  MAX_VALUE = 21
  GAME_FLOW = ["Skip", "Hit", "Show cards"]
  CHOICE = ["Start game", "Quit"]

  def display_choice
    puts "_" * 25
    CHOICE.each_with_index {|choice, i| puts "#{i + 1}: #{choice}"}
  end

  def game_flow
    puts "\n \u2660 #{player.name}, your turn \u2660"
    puts "\n"
    player.show_hand
    GAME_FLOW.each_with_index {|choice, i| puts "#{i + 1}: #{choice}"}
  end

  def dealer_won
    dealer.enroll_money
    player.subtract_money
    puts "\n ---Dealer won!---"
    open_hands
  end

  def player_won
    player.enroll_money
    dealer.subtract_money
    puts "\n ---#{player.name} won!---"
    open_hands
  end

  def open_hands
    puts "\n#{player.name}:"
    puts "- balance: #{player.balance}"
    player.show_hand
    puts "\nDealer:"
    puts "- balance: #{dealer.balance}"
    dealer.show_hand
  end
end
