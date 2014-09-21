require_relative 'card'
require_relative 'deck'
require_relative 'hand'

card = Card.new(:clubs, :ace)

p card.suit
p card.value

deck = Deck.new

hand = Hand::deal_from(deck)

p hand.cards

p hand.flush

#p hand.straight

