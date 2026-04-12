class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end

class Applicant < ApplicationRecord
  has_many :analyses

  validates :name, :cpf, :income, presence: true
  validates :cpf, uniqueness: true
end

class Analysis < ApplicationRecord
  belongs_to :applicant

  validates :score, :status, presence: true
end



#app/services/credit_analyzer.rb
 
class CreditAnalyzer
  def initialize(applicant)
    @applicant = applicant
  end

  def call
    score = calculate_score
    status = decide(score)

    { score: score, status: status }
  end

  private

  def calculate_score
    score = 0

    score += 50 if @applicant.income.to_f > 3000
    score += 30 if cpf_valid?
    score += rand(0..20)

    score
  end

  def decide(score)
    score > 70 ? "approved" : "denied"
  end

  def cpf_valid?
    @applicant.cpf.present? && @applicant.cpf.length == 11
  end
end