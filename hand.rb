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
    :straight_flush,
    :royal_flush
  ]
    

  def self.deal_from(deck)
  	Hand.new(deck.take(5))
  end

  attr_accessor :cards

  def initialize(cards)
  	@cards = cards
  end

  def beats?(other_hand)
    hand, high_card = self.find_my_hand
    other_hand, other_high_card = other_hand.find_my_hand
    
    hand_index = HANDS.index(hand)
    other_hand_index = HANDS.index(other_hand)

    high_card_index = Card.values.index(high_card)
    other_high_card_index = Card.values.index(other_high_card)
    
    return true if hand_index > other_hand_index
    return true if high_card_index > other_high_card_index && 
                   hand_index == other_hand_index
    
    false #determine tie by neither hand beating the other
  end

  def find_my_hand
    result = [:high_card, high_card]
    
    for i in 1..(HANDS.size - 1)
      result = [HANDS[i], send(HANDS[i])] if send(HANDS[i])
    end
      
    result
  end

##### Hand functions, that return relavent highcard for tie
##### returns nil if don't have that hand

  def royal_flush
    return :ace if self.straight && self.flush && high_card == :ace

    nil
  end

  def straight_flush
    self.straight && self.flush
  end

  def four_of_kind
    value_frequency.each do |key, value|
      return key if value == 4
    end
      
    nil
  end

  def full_house
    vals = value_frequency.values
    if vals.include?(3) && vals.include?(2)
      return value_frequency.key(3)
    end
    
    nil
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
    
    result ? high_card : nil  #tie decided by high_card
  end

  def straight
    return straight_high_ace if straight_high_ace
    return straight_low_ace if straight_low_ace
    
    nil
  end

  def straight_high_ace
    #convert cards to index values
    card_index = our_values.map {|value| Card::values.index(value) }
    return high_card if card_index.max - card_index.min == 4
    
    nil
  end

  def straight_low_ace
    cards_need = [:ace, :deuce, :three, :four, :five]
    result = true
      
    cards_need.each do |card|
      result = false unless our_values.include?(card)
    end
      
    result ? :five : nil
  end

  def three_of_kind
    value_frequency.each do |key, value|
      return key if value == 3
    end
    
    nil
  end

  def two_pair
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