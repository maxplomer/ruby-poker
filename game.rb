require_relative 'hand'
require_relative 'deck'
require_relative 'player'

class Game

  attr_reader :current_bet, :bets

  def initialize(deck, players)
  	@deck = deck
  	@players = players
    @current_player = 0
    @pot = 0
    @current_bet = 0
    @bets = {}
  end

  def play
    until one_player_has_all_money
      puts "New Hand"

      set_bets_hash

      @current_bet = 0
      @pot = 0

      deal_to_players
    	
      players_bet
      players_discard
      players_bet

      #now divide pot among winners
      winners.each do |winner|
        winner.pay_winnings(@pot / winners.size)
      end
      
      puts "the pot is #{@pot}"
      puts "the winners are:"
      winners.each do |winner|
        puts winner.name 
      end
    end
  end

  ##### Start - functions called in play method #####

  def set_bets_hash
    @bets = {}
    @players.each do |player|
      next if player.bankroll == 0
      @bets[player] = 0
    end
  end

  def deal_to_players #each player is dealt five cards
    @bets.keys.each do |player| 
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
    @bets.keys.each do |player| 
      player.discard(@deck)
    end
  end

  def winners
    winners = @bets.keys.dup

    for i in 0..(winners.size - 2)
      for j in (i+1)..(winners.size - 1)
        next if winners[i].nil? || winners[j].nil?
        if winners[i].hand.beats?(winners[j].hand)
          winners[j] = nil
        elsif winners[j].hand.beats?(winners[i].hand)
          winners[i] = nil
        end
      end
    end

    winners.compact
  end

  def one_player_has_all_money
    @players.select{|i| i.bankroll > 0}.size == 1
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