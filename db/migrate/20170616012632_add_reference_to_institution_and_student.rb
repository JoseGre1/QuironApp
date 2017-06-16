class AddReferenceToInstitutionAndStudent < ActiveRecord::Migration[5.0]
  def change
    add_reference(:students, :institution, foreign_key: true)
    add_reference(:institutions, :superuser, foreign_key: true)
  end
end
