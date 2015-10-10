module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :received_comments, as: :commentable,
      class_name: "Comment",
      foreign_key: :commentable_id
  end
end
