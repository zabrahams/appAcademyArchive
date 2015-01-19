class Note < ActiveRecord::Base

  validates :user, :track, :body, presence: true

  belongs_to :user
  belongs_to :track

end
