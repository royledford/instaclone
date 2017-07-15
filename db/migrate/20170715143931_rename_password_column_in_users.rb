class RenamePasswordColumnInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column "users", "hashed_password", "password_digest"
  end
end
