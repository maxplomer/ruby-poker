require_relative 'hand'
require_relative 'deck'
require_relative 'player'

class Game

  def initialize(deck, players)
  	@deck = deck
  	@players = players
    @current_player = 0
    @pot = 0
  end

  def play
  	@players.each do |player| 
      player.hand = Hand::deal_from(@deck) 
      p player.hand.our_values
    end
    

    
    
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