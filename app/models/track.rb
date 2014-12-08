class Track < ActiveRecord::Base

  KIND = %w(regular bonus)

  validates :album, :title, :kind, presence: true
  validates :kind, inclusion: KIND

  has_many :notes
  belongs_to :album

end
