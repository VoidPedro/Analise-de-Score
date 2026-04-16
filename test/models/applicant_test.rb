require "test_helper"

class ApplicantTest < ActiveSupport::TestCase

  test "falha na validacao quando cpf eh invalido" do
    applicant = Applicant.new(name: "Lia", cpf: "12345678900", income: 3000)

    assert_not applicant.valid?
    assert_includes applicant.errors[:cpf], "is invalid"
  end

  test "retorna verdadeiro para cpf valido conhecido" do
    applicant = Applicant.new(name: "Maria", cpf: "52998224725", income: 3000)

    assert applicant.cpf_valid?
  end


  test "retorna falso para cpf com digitos repetidos" do
    applicant = Applicant.new(name: "Pedro", cpf: "11111111111", income: 3000)

    assert_not applicant.cpf_valid?
  end

  test "retorna falso para cpf com tamanho incorreto" do
    applicant = Applicant.new(name: "Ana", cpf: "1234567890", income: 3000)

    assert_not applicant.cpf_valid?
  end
end