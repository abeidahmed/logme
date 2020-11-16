class CreateHeadquarters < ActiveRecord::Migration[6.0]
  def change
    create_table :headquarters, id: :uuid do |t|
      t.string :name,       null: false
      t.string :description

      t.timestamps
    end
  end
end
