require "test_helper"

class AnalysisTest < ActiveSupport::TestCase
  def setup
    @valid_cpf = "52998224725"
    @invalid_cpf = "11111111111"
  end


  test "baixa renda valido cpf" do
    applicant = Applicant.new(name: "Maria", cpf: @valid_cpf, income: 1000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 30, result[:score]
  end

  test "baixa renda invalido cpf" do
    applicant = Applicant.new(name: "Joao", cpf: @invalid_cpf, income: 2000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 5, result[:score]
  end

  test "media renda 3000 valido cpf" do
    applicant = Applicant.new(name: "Pedro", cpf: @valid_cpf, income: 3000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 80, result[:score]
  end

  test "media renda 4000 valido cpf" do
    applicant = Applicant.new(name: "Ana", cpf: @valid_cpf, income: 4000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 80, result[:score]
  end

  test "media renda invalido cpf" do
    applicant = Applicant.new(name: "Bruno", cpf: @invalid_cpf, income: 3500)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 50, result[:score]
  end

  test "alta renda 5000 valido cpf" do
    applicant = Applicant.new(name: "Carlos", cpf: @valid_cpf, income: 5000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 100, result[:score]
  end

  test "alta renda 6000 valido cpf" do
    applicant = Applicant.new(name: "Diana", cpf: @valid_cpf, income: 6000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 100, result[:score]
  end

  test "alta renda 10000 invalido cpf" do
    applicant = Applicant.new(name: "Eduardo", cpf: @invalid_cpf, income: 10000)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 70, result[:score]
  end

  test "borderline 2999 valido cpf" do
    applicant = Applicant.new(name: "Felipe", cpf: @valid_cpf, income: 2999)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 30, result[:score]
  end

  test "borderline 4999 valido cpf" do
    applicant = Applicant.new(name: "Gabriela", cpf: @valid_cpf, income: 4999)
    result = CreditScoreCalculator.new(applicant).calculate
    assert_equal 80, result[:score]
  end

  test "historico renda 5000" do
    applicant = Applicant.new(name: "Helena", cpf: @invalid_cpf, income: 1000)
    calculator = CreditScoreCalculator.new(applicant, 5000, true)
    result = calculator.calculate
    assert_equal 100, result[:score]
  end

  test "historico renda 3000 invalido" do
    applicant = Applicant.new(name: "Igor", cpf: @valid_cpf, income: 5000)
    calculator = CreditScoreCalculator.new(applicant, 3000, false)
    result = calculator.calculate
    assert_equal 50, result[:score]
  end
end
