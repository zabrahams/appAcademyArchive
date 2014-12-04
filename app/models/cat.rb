class Cat < ActiveRecord::Base

  def self.colors
    %w(black white orange tabby calico lime_green)
  end

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: Cat.colors }
  validates :sex, inclusion: { in: %w(M F) }

  has_many(:rental_requests, class_name: 'CatRentalRequest',
           foreign_key: :cat_id, primary_key: :id, dependent: :destroy)

end
