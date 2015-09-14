TrelloClone.Collections.Cards = TrelloClone.BetterCollection.extend({
  url: "api/cards",

  comparator: function (card) {
    return card.get("ord");
  },

  model: TrelloClone.Models.Card
});
