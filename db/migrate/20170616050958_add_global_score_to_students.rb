class AddGlobalScoreToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :global_score, :string
  end
end
