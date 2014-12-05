class Session < ActiveRecord::Base
  validates :user_id, :token, presence: true
  belongs_to(:user, class_name: 'User', foreign_key: :user_id, primary_key: :id)

  after_initialize :set_session_token

  def set_session_token!
    self.token ||= SecureRandom::urlsafe_base64
  end
end
