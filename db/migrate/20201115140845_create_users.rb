class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name,             null: false
      t.string :email,            null: false
      t.string :password_digest
      t.string :auth_token,       null: false

      t.timestamps
    end
    add_index :users, [:email, :auth_token]
  end
end
