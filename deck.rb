class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    new_array = []
    
    Card.suits.each do |suit|
      Card.values.each do |value|
        new_array << Card.new(suit, value)
      end
    end

    new_array
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if n > count
    new_array = []
    
    n.times do
      new_array << @cards.shift
    end
    
    new_array
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
     @cards += cards
  end

end