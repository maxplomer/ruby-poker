require_relative 'hand'
require_relative 'deck'
require_relative 'player'

class Game

  attr_reader :current_bet #, :bets

  def initialize(deck, players)
  	@deck = deck
  	@players = players
    @current_player = 0
    @pot = 0
    @current_bet = 0
    @bets = {}
  end

  def play
    deal_to_players
  	
    #set current bet and pot to zero, and bets hash to empty
    @current_bet = 0
    @pot = 0
    set_bets_hash

    players_bet
    players_discard
    players_bet

    ### determine winner, give them all the money
    ### have some sort of output saying results
    ### put inside loop that says
    ### until one player has all the money



    
  end

  ##### Start - functions called in play method #####

  def set_bets_hash
    @bets = {}
    @players.each do |player|
      @bets[player] = 0
    end
  end

  def deal_to_players #each player is dealt five cards
    @players.each do |player| 
      player.hand = Hand::deal_from(@deck) 
    end
  end

  def players_bet
    while true
      @bets.keys.each do |player| #i delete player's key when fold
        player.bet(self)
      end

      break if @bets.values.uniq.length == 1
    end
  end

  def players_discard ###didn't write yet
    @players.each do |player| 
      player.discard(@deck)
    end
  end

##### End - functions called in play method #####

  def take_bets(player, bet_amt)
    @bets[player] += bet_amt
    @current_bet = @bets.values.max
    @pot += bet_amt
  end

  def how_much_bet(player)
    @bets[player]
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