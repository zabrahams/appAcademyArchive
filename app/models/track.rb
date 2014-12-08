class Track < ActiveRecord::Base

  KIND = %w(regular bonus)

  validates :album, :title, :kind, presence: true
  validates :kind, inclusion: KIND

  has_many :notes, inverse_of: :track, dependent: :destroy
  belongs_to :album

end
