class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.float :icfes_score
      t.float :extra_score
      t.float :school_score
      t.string :gender

      t.timestamps
    end
  end
end
