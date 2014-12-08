class User < ActiveRecord::Base

  attr_reader :password

  validates :email, :password_digest, :session_token,
            :activation_token, presence: true
  validates :email, uniqueness: true
  validates :activated, inclusion: [true, false]
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :notes, inverse_of: :user

  after_initialize :ensure_session_token, :ensure_activation_token
  after_create :send_activation_email

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.has_password?(password) ? (return user) : (return nil) #don't need return
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def has_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save!
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def send_activation_email
    msg = UserMailer.activation_email(self)
    msg.deliver
  end

  def ensure_activation_token
    self.activation_token ||= SecureRandom.urlsafe_base64
  end


end
