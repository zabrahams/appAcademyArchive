class Response < ActiveRecord::Base

  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_poller

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
    )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    question
      .responses
      .where("? is NULL OR responses.id != ?", self.id, self.id)

  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:user_id] << "user has already responded"
    end
  end

  def respondent_is_not_poller
    if self.question.poll.author_user_id == self.user_id
      errors[:user_id] << "user can't respond to own poll"
    end
  end

end
