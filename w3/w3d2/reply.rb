class Reply < ModelBase
  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_parent_id(parent_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  attr_accessor :id, :body, :parent_id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    return nil if parent_id.nil?
    Reply.find_by_id(parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(id)
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, parent_id, body, user_id, question_id)
        INSERT INTO
          replies (parent_id, body, user_id, question_id)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, parent_id, body, user_id, question_id, id)
        UPDATE replies
        SET parent_id = ?,
            body = ?,
            user_id = ?,
            question_id = ?
        WHERE
          id = ?
      SQL
    end
  end
end
