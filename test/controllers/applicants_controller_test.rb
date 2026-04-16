require "test_helper"

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
  end

  test "cria applicant com sucesso via POST applicants" do
    assert_difference("Applicant.count") do
      post applicants_url, params: { applicant: { cpf: "98765432100", income: @applicant.income, name: "Novo Applicant" } }
    end

    assert_redirected_to applicant_url(Applicant.last)
  end

  test "retorna detalhes do applicant via GET applicants id" do
    get applicant_url(@applicant)
    assert_response :success
  end

  test "nao cria applicant com cpf duplicado" do
    assert_no_difference("Applicant.count") do
      post applicants_url, params: { applicant: { cpf: @applicant.cpf, income: 2500, name: "Duplicado" } }
    end

    assert_response :unprocessable_entity
  end
end