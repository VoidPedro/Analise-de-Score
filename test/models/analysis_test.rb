require "test_helper"

class AnalysisTest < ActiveSupport::TestCase
  test "calcula score e status via callback quando campos estao ausentes" do
    applicant = Applicant.create!(name: "Maria", cpf: "39053344705", income: 5000)
    analysis = Analysis.new(applicant: applicant)

    assert analysis.valid?
    assert_equal 100, analysis.score
    assert_equal "approved", analysis.status
  end

  test "nao sobrescreve score e status pre-preenchidos" do
    applicant = Applicant.create!(name: "Joao", cpf: "11144477735", income: 1000)
    analysis = Analysis.new(applicant: applicant, score: 42, status: "denied")

    assert analysis.valid?
    assert_equal 42, analysis.score
    assert_equal "denied", analysis.status
  end

  test "recalcula score e status quando applicant muda" do
    first_applicant = Applicant.create!(name: "Ana", cpf: "52998224725", income: 1000)
    second_applicant = Applicant.create!(name: "Beto", cpf: "86288366757", income: 5000)

    analysis = Analysis.create!(applicant: first_applicant)
    assert_equal 30, analysis.score
    assert_equal "denied", analysis.status

    analysis.update!(applicant: second_applicant)
    assert_equal 100, analysis.score
    assert_equal "approved", analysis.status
  end
end