class Album < ActiveRecord::Base

  KIND = %w(live studio)

  validates :band, :title, :kind, presence: true
  validates :kind, inclusion: KIND
  validates :band, uniqueness: { scope: :title }

  belongs_to :band
  has_many :tracks, inverse_of: :album, dependent: :destroy


end
