require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :submitter_id, presence: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  def self.random_code
    short_code = nil
    loop do
      short_code = SecureRandom.urlsafe_base64
      break unless ShortenedUrl.exists?(short_url: short_code)
    end
    short_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(submitter_id: user.id,
                     long_url: long_url,
                     short_url: ShortenedUrl.random_code)
  end


end
