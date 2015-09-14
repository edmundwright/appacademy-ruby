TrelloClone.Collections.Lists = TrelloClone.BetterCollection.extend({
  url: "api/lists",

  comparator: function(list) {
    return list.get("ord");
  },

  model: TrelloClone.Models.List
});
