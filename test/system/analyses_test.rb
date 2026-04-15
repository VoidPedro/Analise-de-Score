require "application_system_test_case"

class AnalysesTest < ApplicationSystemTestCase
  setup do
    @analysis = analyses(:one)
  end

  test "visiting the index" do
    visit analyses_url
    assert_selector "h1", text: "Todas as Análises"
  end

  test "should create analysis" do
    visit analyses_url
    click_on "Nova Análise"

    select @analysis.applicant.name, from: "Selecione um Solicitante"
    click_on "Gerar Análise"

    assert_text "Analysis was successfully created"
  end

  test "should update Analysis" do
    visit analysis_url(@analysis)
    click_on "Editar", match: :first

    click_on "Salvar Alterações"

    assert_text "Analysis was successfully updated"
  end

  test "should destroy Analysis" do
    visit analysis_url(@analysis)
    click_on "Deletar", match: :first

    assert_text "Analysis was successfully destroyed"
  end
end
