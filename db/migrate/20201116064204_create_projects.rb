class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string      :name,         null: false
      t.string      :url,          null: false
      t.string      :subdomain,    null: false
      t.text        :description
      t.references  :headquarter,  null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :projects, :subdomain
  end
end
