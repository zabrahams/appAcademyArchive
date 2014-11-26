require 'SecureRandom'

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :submitter_id, presence: true
  validates :long_url, length: { maximum: 1024 }
  validate :maximum_five_urls_per_min_per_user

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
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
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self
      .visitors
      .where({ :'visits.created_at' => (10.minutes.ago)..Time.now })
      .count || 0
  end

end

private

def maximum_five_urls_per_min_per_user
  number_urls = ShortenedUrl
    .joins('INNER JOIN "users" ON "users"."id" = "shortened_urls"."submitter_id"')
    .where({:'users.id' => self.submitter_id,
      :'shortened_urls.created_at' => (1.minutes.ago)..Time.now,
     }).count
  if number_urls > 4
    errors[:base] << "Too many urls in the last minute"
  end
end
