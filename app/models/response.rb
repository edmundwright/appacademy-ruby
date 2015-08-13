class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :respondent_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author

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

private

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(respondent_id: respondent_id)
      errors[:respondent] << "has already answered this question!"
    end
  end

  def respondent_is_not_author
    if question.poll.author_id == respondent_id
      errors[:respondent] << "is the author!"
    end
  end

  def sibling_responses
    query = question.responses
    id.nil? ? query : query.where("responses.id != ?", id)
  end
end
