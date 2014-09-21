####want to make a new hand and put what i know to be a flush/straight etc
####run hand finder and also hand comparison
require_relative 'card'
require_relative 'deck'
require_relative 'hand'

cards = [
  Card.new(:clubs, :nine),
  Card.new(:clubs, :king),
  Card.new(:clubs, :queen),
  Card.new(:clubs, :jack),
  Card.new(:clubs, :ten),
]


hand = Hand.new(cards)

p hand.find_my_hand