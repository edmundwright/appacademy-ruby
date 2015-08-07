require_relative 'card'

class Deck
  attr_accessor :cards

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

  def take(n)
    cards.pop(n)
  end

  def deal(n)
    take(n)
  end

  def return(cards)
    self.cards += cards
  end
end
