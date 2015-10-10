window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new JournalApp.Routers.Router({ $rootEl: $("body") });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
