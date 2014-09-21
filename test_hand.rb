####want to make a new hand and put what i know to be a flush/straight etc
####run hand finder and also hand comparison
require_relative 'card'
require_relative 'deck'
require_relative 'hand'

cards = [
  Card.new(:clubs, :ace),
  Card.new(:clubs, :ace),
  Card.new(:clubs, :ace),
  Card.new(:clubs, :ace),
  Card.new(:hearts, :ace),
]


hand = Hand.new(cards)
p hand.find_my_hand