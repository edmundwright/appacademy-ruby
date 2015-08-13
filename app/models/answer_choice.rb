class AnswerChoice < ActiveRecord::Base
  validates :text, presence: true
  validates :question_id, presence: true
  after_destroy :log_destroy_action

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    dependent: :destroy,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id

  def log_destroy_action
    puts "Answer choice destroyed."
  end
end
