class Post < ActiveRecord::Base

  validates :title, :sub, :author, presence: true

  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :sub

end
