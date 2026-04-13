class CreditScoreCalculator
  def initialize(applicant, income_at_analysis = nil, cpf_valid_at_analysis = nil)
    @applicant = applicant
    @income_at_analysis = income_at_analysis || applicant.income
    @cpf_valid_at_analysis = cpf_valid_at_analysis != nil ? cpf_valid_at_analysis : applicant.cpf_valid?
  end

  def calculate
    score = 0
    score += 50 if @income_at_analysis > 3000
    score += 30 if @cpf_valid_at_analysis

    status = score > 70 ? "approved" : "denied"

    { score: score, status: status }
  end
end
