class CatRentalRequest < ActiveRecord::Base
  def self.statuses
    %w(PENDING APPROVED DENIED)
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: CatRentalRequest.statuses }
  validate :no_approved_overlapping_requests

  before_validation :set_initial_status

  belongs_to(:cat, class_name: 'Cat', foreign_key: :cat_id, primary_key: :id)


  def overlapping_requests
    requests = CatRentalRequest
                .all
                .where(cat_id: self.cat_id)
                .where("(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)",
                   self.start_date, self.end_date, self.start_date, self.end_date)
                .where("id IS NULL OR id != ?", self.id)
  end

  def overlapping_approved_requests
    overlapping_requests.select("status = 'APPROVED'")
  end

    def set_initial_status
      self.status ||= "PENDING"
    end

  private

  def no_approved_overlapping_requests
    unless overlapping_approved_requests.empty?
      errors[:base] << "must not have conflicting requests."
    end
  end
end
