require "application_system_test_case"

class ApplicantsTest < ApplicationSystemTestCase
  setup do
    @applicant = applicants(:one)
  end

  test "visiting the index" do
    visit applicants_url
    assert_selector "h1", text: "Aplicantes"
  end

  test "should create applicant" do
    visit applicants_url
    click_on "Novo Aplicante"

    fill_in "Nome", with: "João Silva"
    fill_in "CPF (11 dígitos)", with: "52998224725"
    fill_in "Renda Mensal (R$)", with: "5000"
    click_on "Salvar"

    assert_text "Applicant was successfully created"
    click_on "Voltar"
  end

  test "should update Applicant" do
    visit applicant_url(@applicant)
    click_on "Editar", match: :first

    fill_in "Nome", with: @applicant.name
    fill_in "Renda Mensal (R$)", with: @applicant.income
    click_on "Salvar Alterações"

    assert_text "Applicant was successfully updated"
  end

  test "should destroy Applicant" do
    visit applicant_url(@applicant)
    click_on "Deletar", match: :first

    assert_text "Applicant was successfully destroyed"
  end
end
