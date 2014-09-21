require_relative 'card'

class Hand

  def self.deal_from(deck)
  	Hand.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
  	@cards = cards
  end

  def beats?(other_hand)
    #result =  
  end

  def royal_flush?
  end

  def straight_flush?
    self.straight && self.flush
  end

  def four_of_a_kind?
  end

  def full_house
    #return [true, highest pair card] 
  end

  def flush
    #all the same suit ? 
    first_suit = @cards[0].suit
    result = true
    (1..4).each do |i|
      unless @cards[i].suit == first_suit
        result = false
      end
    end
    result
  end

  def straight 
    #ace can be in beginning or at end
    p Card.values
    

    #lowest_card = 
  end

  def three_of_a_kind
  end

  def two_pair
  end

  def one_pair
  end

  def high_card?


    #return [true, highest card]
  end

end