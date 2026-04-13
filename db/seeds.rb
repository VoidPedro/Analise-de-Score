# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Limpar dados antigos
Applicant.destroy_all
Analysis.destroy_all

# Criar aplicantes com CPF válidos
applicants = [
  { name: "João Silva", cpf: "11144477735", income: 5000 },
  { name: "Maria Santos", cpf: "14476157000", income: 2500 },
  { name: "Pedro Oliveira", cpf: "14476157001", income: 1500 },
  { name: "Ana Costa", cpf: "14476157002", income: 4500 },
]

applicants.each do |attrs|
  Applicant.find_or_create_by!(cpf: attrs[:cpf]) do |ap|
    ap.name = attrs[:name]
    ap.income = attrs[:income]
  end
end

puts "✓ #{Applicant.count} solicitantes criados"

# Criar algumas análises automaticamente
Applicant.all.each do |applicant|
  Analysis.create!(applicant: applicant)
end

puts "✓ #{Analysis.count} análises criadas"
