JournalApp.Views.PostForm = Backbone.View.extend({
  tagName: "form",

  template: JST['postForm'],

  events: {
    "click button": "submitForm"
  },

  render: function() {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  submitForm: function (e) {
    e.preventDefault();

    this.model.save(this.$el.serializeJSON().post, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate("posts/" + this.model.id, {trigger: true});
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
