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
      puts "You have bet $" + game.how_much_bet(self).to_s
      puts "type 'fold' to fold"
      puts "type 'see' to see current bet"
      puts "type 'raise 100' to raise bet $100"

      input = gets.chomp.strip

      if input == "fold"
        fold(game)
        return nil 
      elsif input == "see"
        bet_amt = game.current_bet 
                - game.how_much_bet(self)
        place_bet(game, bet_amt)
      elsif input.split[0] == "raise"
        raise_amount = input.split[1].to_i  
        raise "invalid input" if raise_amount <= 0
        bet_amt = raise_amount 
                + game.current_bet 
                - game.how_much_bet(self)
        place_bet(game, bet_amt)
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

  def discard(deck)
    begin
      puts "Here are your cards"

      @hand.cards.each_with_index do |card, index|
        puts "Card #{index}: #{card.value} of #{card.suit}"
      end
      
      puts "enter the indices to discard (ex: 1,3,4 ) "
      i_discard = gets.chomp.split(',').map(&:to_i)
      
      return if i_discard.empty?

      n_discard = i_discard.length

      keep_cards = []
      return_cards = []
      @hand.cards.each_with_index do |card, index|
        if i_discard.include?(index)
           return_cards << card
        else
           keep_cards << card
        end
      end

      deck.return(return_cards)

      @hand.cards = keep_cards + deck.take(n_discard)
    rescue 
      puts "You messed up try again"
      retry
    end
  end


  def place_bet(game, bet_amt)
    raise "player can't cover bet" if bet_amt > @bankroll
    game.take_bet(self, bet_amt)
    @bankroll -= bet_amt
    nil
  end
  
end