require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end


class ApplicantTest < ActiveSupport::TestCase
  test "não salva sem nome" do
    applicant = Applicant.new(cpf: "12345678909", income: 2000)

    assert_not applicant.save
  end

test "cpf válido retorna true" do
  applicant = Applicant.new(
    name: "Pedro",
    cpf: "52998224725", # CPF válido
    income: 2000
  )

  assert applicant.cpf_valid?
end


test "cpf inválido retorna false" do
  applicant = Applicant.new(
    name: "Pedro",
    cpf: "11111111111",
    income: 2000
  )

  assert_not applicant.cpf_valid?
end
end





lógica de crédito
