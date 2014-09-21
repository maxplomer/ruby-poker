class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @hand = nil
  end

  def pay_winnings(bet_amt)
    @bankroll += bet_amt
  end

  def return_cards(deck)
    hand.return_cards(deck)
    self.hand = nil
  end

  def bet(game)
    begin 
      puts "Current bet is $" + game.current_bet.to_s
      puts "type 'fold' to fold"
      puts "type 'see' to see current bet"
      puts "type 'raise 100' to raise bet $100"

      input = gets.chomp.strip

      if input == "fold"
        fold(game)
        return nil 
      elsif input == "see"
        place_bet(game, game.current_bet)
      elsif input.split[0] == "raise"
        place_bet(game, input.split[1])
      else
        raise "invalid input"
      end

    rescue "player can't cover bet"
      puts "you don't have enough money"
      retry
    rescue "invalid input"
      puts "invalid input"
      retry
    end

    nil  
  end

  def fold(game)
    game.bets.delete(self)
    nil
  end

  def place_bet(game, bet_amt)
    raise "player can't cover bet" if bet_amt > @bankroll
    game.take_bet(self, bet_amt)
    @bankroll -= bet_amt
    nil
  end
  
end