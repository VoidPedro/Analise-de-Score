class Analysis < ApplicationRecord
  belongs_to :applicant
  
  before_validation :calculate_credit_score
  
  validates :applicant_id, presence: true
  validates :score, presence: true, numericality: true
  validates :status, presence: true, inclusion: { in: %w(approved denied) }
  
  private
  
  def calculate_credit_score
    return if score.present? && status.present?
    
    calculator = CreditScoreCalculator.new(applicant)
    result = calculator.calculate
    self.score = result[:score]
    self.status = result[:status]
  

  end
end