class Sub < ActiveRecord::Base

  validates :title, :moderator, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id

  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :posts, through: :post_subs

end
