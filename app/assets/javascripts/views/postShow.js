JournalApp.Views.PostShow = Backbone.View.extend({
  events: {
    "click button.delete": "delete",
    "dblclick .post-title": "makeEditable",
    "dblclick .post-body": "makeEditable",
    "submit form": "saveField"
  },

  template: JST["postShow"],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.editingTitle = false;
    this.editingBody = false;
  },

  render: function () {
    var content = this.template({
      post: this.model,
      editingTitle: this.editingTitle,
      editingBody: this.editingBody
    });
    this.$el.html(content);
    return this;
  },

  delete: function() {
    this.model.destroy();
    Backbone.history.navigate("", {trigger: true})
  },

  makeEditable: function(e) {
    if ($(e.currentTarget).hasClass("post-title")) {
      this.editingTitle = true;
    } else {
      this.editingBody = true;
    }
    this.render();
  },

  saveField: function (e) {
    e.preventDefault();

    this.model.save($(e.currentTarget).serializeJSON().post, {
      success: function () {
        if ($(e.currentTarget).hasClass("edit-title")){
          this.editingTitle = false;
        } else {
          this.editingBody = false;
        }
        this.render();
      }.bind(this),

      error: function (_, response) {
        this.$el.find("ul.errors").empty();
        response.responseJSON.forEach(function (errorText) {
          var $li = $("<li>");
          $li.text(errorText);
          this.$el.find("ul.errors").append($li);
        }.bind(this))
      }.bind(this)
    })
  }
});
