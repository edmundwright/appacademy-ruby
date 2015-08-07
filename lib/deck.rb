require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = make_deck
  end

  def make_deck
    result = []

    Card.values.each do |value|
      Card.suits.each { |suit| result << Card.new(suit, value) }
    end

    result
  end
end
