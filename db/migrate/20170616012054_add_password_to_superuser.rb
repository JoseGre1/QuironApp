class AddPasswordToSuperuser < ActiveRecord::Migration[5.0]
  def change
    add_column :superusers, :password_digest, :string
  end
end
