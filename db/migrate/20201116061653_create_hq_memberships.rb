class CreateHqMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :hq_memberships, id: :uuid do |t|
      t.string      :role,                null: false, default: "member"
      t.datetime    :join_date
      t.boolean     :invitation_accepted, null: false, default: true
      t.references  :user,                null: false, foreign_key: true, type: :uuid
      t.references  :headquarter,         null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :hq_memberships, [:role, :invitation_accepted]
  end
end
