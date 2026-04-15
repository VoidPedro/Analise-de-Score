class Applicant < ApplicationRecord
  has_many :analyses, dependent: :destroy
  
  validates :name, :cpf, :income, presence: true
  validates :cpf, uniqueness: true, length: { is: 11 }
  validates :income, numericality: { greater_than_or_equal_to: 0 }
  validate :cpf_must_be_valid?
  # Atributos principais:
  # - name: string (nome do solicitante)
  # - cpf: string (11 dígitos, sem formatação)
  # - income: decimal (renda mensal)
  
  def cpf_valid?
    cpf_clean = self.cpf.to_s.gsub(/\D/, "")
    
    return false if cpf_clean.length != 11
    
    sum = cpf_clean[0..8].chars.each_with_index.sum { |digit, index| digit.to_i * (10 - index) }
    first_digit = (sum * 10) % 11
    first_digit = 0 if first_digit >= 10
    
    return false if first_digit != cpf_clean[9].to_i
    
    sum = cpf_clean[0..9].chars.each_with_index.sum { |digit, index| digit.to_i * (11 - index) }
    second_digit = (sum * 10) % 11
    second_digit = 0 if second_digit >= 10
    
  end

  def cpf_must_be_valid?
    unless cpf_valid?
      errors.add(:cpf, "inválido")
    end
  end

end
