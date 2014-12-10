class Post < ActiveRecord::Base

  validates :title, :author, presence: true
  validate :valid_url

  belongs_to :author, class_name: "User", foreign_key: :author_id

  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs
  has_many :comments
  has_many :votes, as: :votable

  def comments_by_parent_id
    hash = Hash.new { |h, v| h[v] = [] }
    self.comments.each do |comment|
      hash[comment.parent_comment_id] << comment
    end
    hash
  end

  def vote_total
    self.votes.pluck(:value).inject(:+)
  end

  private

  def valid_url
    unless url.nil? || url[0..6] == "http://"
      errors[:url] << "URL must begin with http://"
    end
  end

end
