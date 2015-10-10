class User < ActiveRecord::Base
  validates :user_name, :presence => true, :uniqueness => true

  has_many :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id

  has_many :responses,
    class_name: "Response",
    foreign_key: :respondent_id,
    primary_key: :id

  def completed_polls
    answered_and_unanswered_questions
      .having("COUNT(user_responses.respondent_id) = COUNT(DISTINCT questions.id)")
  end

  def uncompleted_polls
    answered_and_unanswered_questions
      .having("COUNT(user_responses.respondent_id) < COUNT(DISTINCT questions.id)")
  end

  def completed_polls_sql
    Poll.find_by_sql([<<-SQL, id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON questions.poll_id = polls.id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        (
          SELECT
            *
          FROM
            responses
          WHERE
            respondent_id = ?
        ) AS user_responses
      ON user_responses.answer_choice_id = answer_choices.id
      GROUP BY
        polls.id
      HAVING
        COUNT(user_responses.respondent_id) = COUNT(DISTINCT questions.id)
    SQL
  end

  private

    def answered_and_unanswered_questions
      user_responses = Response
        .select("*")
        .where("respondent_id = ?", id)

      Poll
        .select("polls.*")
        .joins("JOIN questions ON questions.poll_id = polls.id")
        .joins("JOIN answer_choices ON answer_choices.question_id = questions.id")
        .joins("LEFT OUTER JOIN (#{user_responses.to_sql}) AS user_responses
                ON user_responses.answer_choice_id = answer_choices.id")
        .group("polls.id")
    end

end
