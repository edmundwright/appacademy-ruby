require 'deck'

describe Deck do
  let(:deck) { Deck.new }

  it "initializes an array of cards" do
    expect(deck.cards.all? { |card| card.is_a?(Card) }).to be true
  end

  it "initializes with 52 cards" do
    expect(deck.cards.count).to eq(52)
  end

  it "initializes with unique cards" do
    values = deck.cards.map { |card| card.value }.uniq
    suits = deck.cards.map { |card| card.suit }.uniq
    expect(values.length).to eq(13)
    expect(suits.length).to eq(4)
  end
end
