class User < ModelBase
  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    results.map { |result| User.new(result) }
  end

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        (COUNT(question_likes.user_id) / CAST(COUNT(DISTINCT questions.id) AS FLOAT))
        AS avg
      FROM
        questions
      LEFT OUTER JOIN
        question_likes on questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
    SQL
    result.first['avg']
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
        UPDATE users
        SET fname = ?,
            lname = ?
        WHERE
          id = ?
      SQL
    end
  end
end
