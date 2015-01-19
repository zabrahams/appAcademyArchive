class Poll < ActiveRecord::Base

validates :author_user_id, :title, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_user_id,
    primary_key: :id
  )

  has_many(
    :questions,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id,
    dependent: :destroy
    )


end
