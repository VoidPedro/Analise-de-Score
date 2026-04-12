class Applicant < ApplicationRecord
  has_many :analyses, dependent: :destroy
  
  validates :name, :cpf, :income, presence: true
  validates :cpf, uniqueness: true, length: { is: 11 }
  validates :income, numericality: { greater_than_or_equal_to: 0 }
  
  # Atributos principais:
  # - name: string (nome do solicitante)
  # - cpf: string (11 dígitos, sem formatação)
  # - income: decimal (renda mensal)
  
  def cpf_valid?
    cpf = cpf.to_s.gsub(/\D/, "")
    
    return false if cpf.length != 11
    return false if cpf == cpf[0] * 11
    
    sum = cpf[0..8].chars.each_with_index.sum { |digit, index| digit.to_i * (10 - index) }
    first_digit = (sum * 10) % 11
    first_digit = 0 if first_digit >= 10
    
    return false if first_digit != cpf[9].to_i
    
    sum = cpf[0..9].chars.each_with_index.sum { |digit, index| digit.to_i * (11 - index) }
    second_digit = (sum * 10) % 11
    second_digit = 0 if second_digit >= 10
    
    second_digit == cpf[10].to_i
  end
end
