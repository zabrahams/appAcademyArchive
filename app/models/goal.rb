class Goal < ActiveRecord::Base

  validates :title, :body, :author_id, presence: true
  validates :title, uniqueness: { scope: :author_id }
  validates :pub_status, :completed, inclusion: [true, false]

  belongs_to :author, class_name: "User"
end
