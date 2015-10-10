$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$el.on('submit', this.submit.bind(this));
  this.$el.find('textarea').on('input', this.count.bind(this));
  this.$el.find(".add-mentioned-user").on('click', this.addMentionedUser.bind(this));
  this.$el.on('click', ".remove-mentioned-user", this.addMentionedUser.bind(this));
};

$.TweetCompose.prototype.addMentionedUser = function (e) {
  var $scriptTag = this.$el.find('script')
  var html = $scriptTag.html();
  this.$el.find(".mentioned-users").append(html);
};

$.TweetCompose.prototype.count = function (e) {
  var count = 140 - this.$el.find('textarea').val().length;
  this.$el.find('.chars-left').text(count);
}

$.TweetCompose.prototype.submit = function (e) {
  e.preventDefault();
  var formContent = this.$el.serializeJSON();
  this.$el.find(":input").prop({disabled: true});

  $.ajax({
    method: "post",
    url: "/tweets",
    dataType: "json",
    data: formContent,
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.clearInput = function () {
  this.$el.find(":input").not("[type='Submit']").val("");
};

$.TweetCompose.prototype.handleSuccess = function (tweet) {
  this.clearInput();
  this.$el.find(":input").prop({disabled: false});
  var $ul = $(this.$el.data("tweets-location"));
  var $li = $("<li>" + JSON.stringify(tweet) + "</li>");
  $ul.append($li)
};

$.fn.tweetCompose = function () {
  return this.each(function() {
    new $.TweetCompose(this);
  });
};
