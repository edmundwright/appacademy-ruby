$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('input');
  this.$ul = this.$el.find('ul.users');
  this.$input.on('input', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (e) {
  e.preventDefault();
  $.ajax({
    method: "get",
    url: "/users/search",
    dataType: "json",
    data: {"query": this.$input.val()},
    success: function (users) {
      this.renderResults(users);
    }.bind(this)
  });

  $.UsersSearch.prototype.renderResults = function (users) {
    this.$ul.html("");
    users.forEach(function (user) {
      var link = '<a href="/users/' + user.id + '">' + user.username + '</a>';
      var button = '<button class="follow-toggle"></button>';
      var $li = $('<li>' + link + button +'</li>');
      this.$ul.append($li)
      $li.find('button').followToggle({"userId": user.id, "followState": user.followed });
    }.bind(this))
  }

};

$.fn.usersSearch = function () {
  return this.each(function() {
    new $.UsersSearch(this);
  });
};
