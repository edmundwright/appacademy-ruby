class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "APPROVED", "DENIED"]

  validates :start_date, :end_date, :cat_id, :status, presence: true
  validates :status, inclusion: { in: STATUS, message: "%{value} is not valid" }

  validate :no_overlapping_requests_when_both_approved
  validate :start_date_is_before_end_date


  # after_initialize do |cat_rental_request|
  #  cat_rental_request.start_date ||= Time.now.utc.to_date
  # end

  def overlapping_requests
    CatRentalRequest.where("end_date > ? AND start_date < ?
                            AND (id != ? OR ? IS NULL)
                            AND cat_id = ?",
                            start_date, end_date, id, id, cat_id)
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def start_date_is_before_end_date
    return unless errors.empty?
    if start_date > end_date
      errors[:base] << "Start date should be before end date"
    end
  end

  def no_overlapping_requests_when_both_approved
    return unless errors.empty?
    if overlapping_approved_requests.any? && status == "APPROVED"
      message = "Two approved requests cannot overlap"
      errors[:base] << message
    end
  end

  belongs_to :cat
  # class_name: "Cat",
  # foreign_key: :cat_id
end
