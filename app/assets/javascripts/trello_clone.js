window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    TrelloClone.boards = new TrelloClone.Collections.Boards();
    TrelloClone.cards = new TrelloClone.Collections.Cards();
    new TrelloClone.Routers.Router({
      $rootEl: $("div#main")
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
