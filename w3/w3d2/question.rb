class Question < ModelBase
  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    results.map { |result| Question.new(result)}
  end

  attr_accessor :id, :body, :title, :user_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id)
        INSERT INTO
          questions (title, body, user_id)
        VALUES
          (?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id, id)
        UPDATE questions
        SET title = ?,
            body = ?,
            user_id = ?
        WHERE
          id = ?
      SQL
    end
  end
end
