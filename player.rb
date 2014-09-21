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
    puts "Current bet is $" + game.current_bet
    puts "type 'fold' to fold"
    puts "type 'see' to see current bet"
    puts "type 'raise 100' to raise bet $100"


  end

  def place_bet(dealer, bet_amt)
    raise "player can't cover bet" if bet_amt > @bankroll
    dealer.take_bet(self, bet_amt)
    @bankroll -= bet_amt
  end
  
end