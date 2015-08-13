class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :respondent_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author
  after_destroy :log_destroy_action

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

  def log_destroy_action
    puts "Response destroyed."
  end

  private

    def respondent_has_not_already_answered_question
      if sibling_responses.exists?(respondent_id: respondent_id)
        errors[:respondent] << "has already answered this question!"
      end
    end

    def respondent_is_not_author
      if Poll
        .select("polls.author_id")
        .joins("JOIN questions ON questions.poll_id = polls.id")
        .joins("JOIN answer_choices ON answer_choices.question_id = questions.id")
        .where("answer_choices.id = ?", answer_choice_id)
        .first.author_id == respondent_id
          errors[:respondent] << "is the author!"
      end
    end

    def sibling_responses
      Response
        .select("responses.*")
        .joins("JOIN answer_choices
          ON answer_choices.id = responses.answer_choice_id")
        .joins("JOIN questions ON questions.id = answer_choices.question_id")
        .where("answer_choices.id = :answer_choice_id
                AND (:id IS NULL OR responses.id != :id)",
               answer_choice_id: answer_choice_id, id: id)
    end

    def sibling_responses_nicer
      question.responses.where(":id IS NULL OR responses.id != :id", id: id)
    end
end
