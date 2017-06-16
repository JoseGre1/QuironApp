class AddCityToInstitution < ActiveRecord::Migration[5.0]
  def change
    add_column :institutions, :city, :string
  end
end
