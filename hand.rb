require_relative 'card'

class Hand
    
  HANDS = [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_kind,
    :straight_flush
  ]
    

  def self.deal_from(deck)
  	Hand.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
  	@cards = cards
  end

  def beats?(other_hand)
    #result =
    
    #have list of hands in order, get index value, if one higher
    #than other return winner
    #if tie, then take high card, deal with draw
    
    
    
  end

  def find_my_hand
    result = [:high_card, high_card]
    
    for i in 1..(HANDS.size - 1)
      result = [HANDS[i], send(HANDS[i])] if send(HANDS[i])
    end
      
    result
  end


  def royal_flush?
  end

  def straight_flush?
    self.straight && self.flush
  end

  def four_of_a_kind?
  end

  def full_house?
    #return [true, highest pair card] 
  end

  def flush?
    #all the same suit ? 
    first_suit = @cards[0].suit
    result = true
    (1..4).each do |i|
      unless @cards[i].suit == first_suit
        result = false
      end
    end
    result #tie decided by high_card
  end

  def straight?
    #ace can be in beginning or at end
    p Card.values
    

    #lowest_card = 
  end

  def three_of_a_kind?
    value_frequency.each do |key, value|
      return key if value == 3
    end
    
    nil
  end

  def two_pair?
    pair_values = []
      
    value_frequency.each do |key, value|
      pair_values << key if value == 2
    end
    
    return nil unless pair_values.length == 2
    
    high_pair_card = :deuce
    Card::values.each do |value|
      high_pair_card = value if pair_values.include?(value)
    end
    
    high_pair_card
  end # tie decided by high card of pair

  def one_pair
    value_frequency.each do |key, value|
      return key if value == 2
    end
    
    nil
  end

  def high_card
    high_card = :deuce
    
    Card::values.each do |value|
      high_card = value if our_values.include?(value)
    end
    
    high_card
  end

##### functions shared by calculating pair, 3 of a kind, etc #####

  def our_values
    result = []
    
    @cards.each do |card|
      result << card.value
    end
    
    result
  end

  def value_frequency
    hash = Hash.new(0)
    
    our_values.each do |value|
       hash[value] += 1
    end
    
    hash
  end





end