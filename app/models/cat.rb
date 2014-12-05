class Cat < ActiveRecord::Base
  COLORS = %w(black white orange tabby calico lime_green)

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: %w(M F) }

  has_many(:rental_requests, class_name: 'CatRentalRequest',
           foreign_key: :cat_id, primary_key: :id, dependent: :destroy)

end
