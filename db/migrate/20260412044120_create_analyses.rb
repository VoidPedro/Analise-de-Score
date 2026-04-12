class CreateAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :analyses do |t|
      t.references :applicant, null: false, foreign_key: true
      t.integer :score
      t.string :status

      t.timestamps
    end
  end
end
