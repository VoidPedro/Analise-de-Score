class Analysis < ApplicationRecord
  belongs_to :applicant
  
  before_validation :calculate_credit_score
  
  validates :applicant_id, presence: true
  validates :score, presence: true, numericality: true
  validates :status, presence: true, inclusion: { in: %w(approved denied) }
  
  private
  
  def calculate_credit_score
    # Não recalcula se for um novo registro e já tiver score e status preenchidos
    if new_record? && score.present? && status.present?
      return
    end
    
    if !applicant_id_changed? && score.present? && status.present?
      return
    end
    
    return if applicant.nil?
    
    calculator = CreditScoreCalculator.new(applicant)
    result = calculator.calculate
    self.score = result[:score]
    self.status = result[:status]
  end
end