require_relative 'hand'
require_relative 'deck'
require_relative 'player'

class Game

  attr_reader :current_bet

  def initialize(deck, players)
  	@deck = deck
  	@players = players
    @current_player = 0
    @pot = 0
    @current_bet = 0
    @bets = Hash.new(0)
  end

  def play
    #each player is dealt five cards
  	@players.each do |player| 
      player.hand = Hand::deal_from(@deck) 
    end

    #set current bet to zero, and bets hash to empty
    #alive_player is empty hash
    @current_bet = 0
    @bets = Hash.new(0)

    #players bet
    @players.each do |player| 
      player.bet(self)
    end    
  end

  def take_bets(player, bet_amt)
    @bets[player] += bet_amt
    @current_bet = @bets.values.max
  end

  def next_player
    @current_player = (@current_player + 1) % @player.count
  end

end


if $PROGRAM_NAME == __FILE__
  deck = Deck.new
  deck.shuffle!
  players = [
    Player.new("Jon", 1000),
    Player.new("Tom", 1000)
  ]
  Game.new(deck, players).play
end