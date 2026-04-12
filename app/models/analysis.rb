class Analysis < ApplicationRecord
  belongs_to :applicant
  
  before_create :calculate_credit_score
  
  validates :applicant_id, presence: true
  
  private
  
  def calculate_credit_score
    calculator = CreditScoreCalculator.new(applicant)
    result = calculator.calculate
    self.score = result[:score]
    self.status = result[:status]
  end
end
