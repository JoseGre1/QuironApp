class AddPersonalidToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :personal_id, :string
    add_column :students, :personal_id_type, :string
  end
end
