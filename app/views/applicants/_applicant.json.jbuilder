json.extract! applicant, :id, :name, :cpf, :income, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
