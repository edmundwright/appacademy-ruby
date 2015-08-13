class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    result = {}

    answer_choices
      .select('answer_choices.*, COUNT(responses.id) AS response_count')
      .joins('LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id')
      .group('answer_choices.id')
      .each do |answer_choice|
        result[answer_choice.text] = answer_choice.response_count
      end

    result
  end

  def results_n_plus_1
    choices = answer_choices
    result = {}

    choices.each do |answer_choice|
      result[answer_choice.text] = answer_choice.responses.count
    end

    result
  end

  def results_two
    choices = answer_choices.includes(:responses)
    result = {}

    choices.each do |answer_choice|
      result[answer_choice.text] = answer_choice.responses.length
    end

    result
  end
end
