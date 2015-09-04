$.FollowToggle = function (el, options) {

  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  if (this.$el.data("initial-follow-state") === true || (options && options.followState === true)) {
    this.followState = "followed";
  } else {
    this.followState = "unfollowed";
  }



  this.render();
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === "Unfollowing" || this.followState === "Following") {
    this.$el.prop({disabled: true});
    this.$el.html(this.followState);
  } else {
    this.$el.html((this.followState === "followed") ? "Unfollow!": "Follow!");
    this.$el.prop({disabled: false});
  }
};

$.FollowToggle.prototype.handleClick = function (e) {
  e.preventDefault();
  this.followState = (this.followState === "followed") ? "Unfollowing" : "Following";
  this.render();


  $.ajax({
    dataType: "json",
    method: ((this.followState === "Unfollowing") ? "delete" : "post"),
    url: "/users/" + this.userId + "/follow",
    success: function () {
      this.followState = (this.followState === "Unfollowing") ? "unfollowed" : "followed";
      this.render();
    }.bind(this)

  })




}


$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};
