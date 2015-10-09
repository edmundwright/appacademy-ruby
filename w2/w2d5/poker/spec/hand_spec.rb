require 'hand'

describe Hand do
  let(:card1) { Card.new(:spades, :deuce)}
  let(:card2) { Card.new(:spades, :four)}
  let(:hand) { Hand.new([card1, card2])}

  describe "#initialize" do
    it "initializes with the given cards" do
      expect(hand.cards).to eq([card1, card2])
    end
  end

  context "poker hands" do
    let(:flush_hand) { Hand.new([Card.new(:diamonds, :jack),
                                 Card.new(:diamonds, :ten),
                                 Card.new(:diamonds, :eight),
                                 Card.new(:diamonds, :seven),
                                 Card.new(:diamonds, :deuce)]) }
    let(:straight_hand) { Hand.new([Card.new(:diamonds, :queen),
                                    Card.new(:clubs, :king),
                                    Card.new(:spades, :jack),
                                    Card.new(:hearts, :ten),
                                    Card.new(:spades, :nine)]) }
    let(:straight_flush_hand) { Hand.new([Card.new(:clubs, :king),
                                          Card.new(:clubs, :queen),
                                          Card.new(:clubs, :jack),
                                          Card.new(:clubs, :ten),
                                          Card.new(:clubs, :nine)]) }
    let(:four_hand) { Hand.new([Card.new(:hearts, :ten),
                                Card.new(:diamonds, :ten),
                                Card.new(:clubs, :ten),
                                Card.new(:spades, :ten),
                                Card.new(:clubs, :nine)]) }
    let(:full_house) { Hand.new([Card.new(:hearts, :ten),
                                Card.new(:diamonds, :nine),
                                Card.new(:clubs, :ten),
                                Card.new(:spades, :ten),
                                Card.new(:clubs, :nine)]) }
    let(:three_hand) { Hand.new([Card.new(:hearts, :ten),
                                Card.new(:diamonds, :ten),
                                Card.new(:clubs, :eight),
                                Card.new(:spades, :ten),
                                Card.new(:clubs, :nine)]) }
    let(:two_pair) { Hand.new([Card.new(:hearts, :ten),
                                Card.new(:diamonds, :ten),
                                Card.new(:hearts, :nine),
                                Card.new(:spades, :eight),
                                Card.new(:clubs, :nine)]) }
    let(:one_pair) { Hand.new([Card.new(:hearts, :three),
                                Card.new(:diamonds, :seven),
                                Card.new(:hearts, :nine),
                                Card.new(:spades, :eight),
                                Card.new(:clubs, :nine)]) }
    let(:bad_hand) { Hand.new([Card.new(:diamonds, :four),
                                Card.new(:spades, :ten),
                                Card.new(:hearts, :nine),
                                Card.new(:diamonds, :ace),
                                Card.new(:clubs, :three)]) }
    let(:equally_bad_hand) { Hand.new([Card.new(:diamonds, :four),
                                Card.new(:spades, :ten),
                                Card.new(:hearts, :nine),
                                Card.new(:clubs, :ace),
                                Card.new(:clubs, :three)]) }
    let(:worse_hand) { Hand.new([Card.new(:diamonds, :king),
                                Card.new(:spades, :ten),
                                Card.new(:hearts, :nine),
                                Card.new(:diamonds, :four),
                                Card.new(:clubs, :three)]) }

    describe "#straight_flush?" do
      it "returns false when is flush but not straight" do
        expect(flush_hand.straight_flush?).to be false
      end

      it "returns false when is not flush but straight" do
        expect(straight_hand.straight_flush?).to be false
      end

      it "returns true when flush and straight" do
        expect(straight_flush_hand.straight_flush?).to be true
      end
    end

    describe "#four_of_kind?" do
      it "returns true when passed a four-of-a-kind" do
        expect(four_hand.four_of_kind?).to be true
      end

      it "returns false when passed a non-four-of-a-kind hand" do
        expect(straight_hand.four_of_kind?).to be false
      end
    end

    describe "#full_house?" do
      it "returns true when passed a full-house hand" do
        expect(full_house.full_house?).to be true
      end

      it "returns false when passed a non full-house hand" do
        expect(straight_hand.full_house?).to be false
      end

      it "returns false when passed a three-of-a-kind" do
        expect(three_hand.full_house?).to be false
      end
    end

    describe "#flush?" do
      it "returns true when passed a flush hand" do
        expect(flush_hand.flush?).to be true
      end

      it "returns false when passed a non-flush hand" do
        expect(straight_hand.flush?).to be false
      end

    end

    describe "#straight?" do
      it "returns true when passed a straight hand" do
        expect(straight_hand.straight?).to be true
      end

      it "returns false when passed a non-straight hand" do
        expect(flush_hand.straight?).to be false
      end

    end

    describe "#three_of_kind" do
      it "returns true when passed a three-of-a-kind" do
        expect(three_hand.three_of_kind?).to be true
      end

      it "returns false when passed a non-three-of-a-kind" do
        expect(one_pair.three_of_kind?).to be false
      end

      it "returns false when passed another non-three-of-a-kind" do
        expect(two_pair.three_of_kind?).to be false
      end
    end

    describe "#two_pair?" do
      it "returns true when passed a two-pair" do
        expect(two_pair.two_pair?).to be true
      end

      it "returns false when passed a non-two-pair" do
        expect(one_pair.two_pair?).to be false
      end

      it "returns false when passed another non-two-pair" do
        expect(three_hand.two_pair?).to be false
      end
    end

    describe "#one_pair?" do
      it "returns true when passed a one-pair" do
        expect(one_pair.one_pair?).to be true
      end

      it "returns false when passed a non-one-pair" do
        expect(straight_hand.one_pair?).to be false
      end

      it "returns false when passed another non-one-pair" do
        expect(flush_hand.one_pair?).to be false
      end
    end
    describe "::best_hand" do

      it "returns best of three poker hands" do
        expect(Hand.best_hands([two_pair, flush_hand, full_house])).to eq([full_house])
      end

      it "returns best of two bad hands, using max value" do
        expect(Hand.best_hands([bad_hand, worse_hand])).to eq([bad_hand])
      end

      it "returns ties" do
        expect(Hand.best_hands([bad_hand, equally_bad_hand, worse_hand])).to match_array([bad_hand, equally_bad_hand])
      end
    end
  end
end
