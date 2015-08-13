class QuestionFollow
  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        id, fname, lname
      FROM
        question_follows
      JOIN
        users ON users.id = question_follows.user_id
      WHERE
        question_id = ?
    SQL
    results.map { |result| User.new(result)}
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        id, title, body, questions.user_id
      FROM
        question_follows
      JOIN
        questions ON questions.id = question_follows.question_id
      WHERE
        question_follows.user_id = ?
    SQL
    results.map { |result| Question.new(result)}
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        id, title, body, questions.user_id
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.user_id) DESC
      LIMIT ?
    SQL

    results.map { |result| Question.new(result)}
  end
end
