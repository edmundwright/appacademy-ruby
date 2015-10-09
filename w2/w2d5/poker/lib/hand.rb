require_relative 'card'

class Hand
  POKER_HANDS = [:straight_flush?,
                 :four_of_kind?,
                 :full_house?,
                 :flush?,
                 :straight?,
                 :three_of_kind?,
                 :two_pair?,
                 :one_pair?]

  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def straight_flush?
    flush? && straight?
  end

  def flush?
    cards.map { |card| card.suit}.uniq.length == 1
  end

  def straight?
    last_value = nil
    sorted_values.each do |value|
      return false unless last_value.nil? || (value == last_value + 1)
      last_value = value
    end
    true
  end

  def four_of_kind?
    sorted_values.count(sorted_values[2]) == 4
  end

  def full_house?
    !four_of_kind? && (sorted_values.uniq.length == 2)
  end

  def three_of_kind?
    sorted_values.count(sorted_values[2]) == 3
  end

  def sorted_values
    cards.map { |card| Card::POKER_VALUE[card.value] }.sort
  end

  def two_pair?
    !three_of_kind? && sorted_values.uniq.length == 3
  end

  def one_pair?
    sorted_values.uniq.length == 4
  end

  def Hand.best_hands(hands)
    POKER_HANDS.each do |poker_hand_method|
      winners = hands.select { |hand| hand.send(poker_hand_method) }
      return winners if winners.length > 0
    end
    sorted_hands = hands.sort do |hand1, hand2|
      hand1.max_value <=> hand2.max_value
    end
    sorted_hands.select { |hand| hand.max_value == sorted_hands.last.max_value }
  end

  def max_value
    sorted_values.last
  end

  def inspect
    cards.map { |card| [card.suit, card.value] }.join(",")
  end
end
