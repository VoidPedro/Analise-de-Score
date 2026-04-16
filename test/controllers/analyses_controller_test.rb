require "test_helper"

class AnalysesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
  end

  test "cria analise com sucesso via POST analyses" do
    assert_difference("Analysis.count") do
      post analyses_url, params: { analysis: { applicant_id: @applicant.id } }
    end

    assert_redirected_to analysis_url(Analysis.last)
  end

  test "nao cria analise com applicant inexistente" do
    assert_no_difference("Analysis.count") do
      post analyses_url, params: { analysis: { applicant_id: 999_999 } }
    end

    assert_response :unprocessable_entity
  end
end