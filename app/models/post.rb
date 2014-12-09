class Post < ActiveRecord::Base

  validates :title, :author, presence: true
  validate :valid_url

  belongs_to :author, class_name: "User", foreign_key: :author_id

  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs

  private


  def valid_url
    unless url.nil? || url[0..6] == "http://"
      errors[:url] << "URL must begin with http://"
    end
  end

end
