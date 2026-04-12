class CreditScoreCalculator
  def initialize(applicant)
    @applicant = applicant
  end

  def calculate
    score = 0
    score += 50 if @applicant.income > 3000
    score += 30 if cpf_valid?
    score += rand(0..20)

    status = score > 70 ? "approved" : "denied"

    { score: score, status: status }
  end

  private

  def cpf_valid?
    cpf = @applicant.cpf.to_s.gsub(/\D/, "")
    
    # Verifica tamanho
    return false if cpf.length != 11
    
    # Verifica se todos os dígitos são iguais
    return false if cpf == cpf[0] * 11
    
    # Calcula primeiro dígito verificador
    sum = cpf[0..8].chars.each_with_index.sum { |digit, index| digit.to_i * (10 - index) }
    first_digit = (sum * 10) % 11
    first_digit = 0 if first_digit >= 10
    
    return false if first_digit != cpf[9].to_i
    
    # Calcula segundo dígito verificador
    sum = cpf[0..9].chars.each_with_index.sum { |digit, index| digit.to_i * (11 - index) }
    second_digit = (sum * 10) % 11
    second_digit = 0 if second_digit >= 10
    
    second_digit == cpf[10].to_i
  end
end
