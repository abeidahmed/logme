class CreateProjectMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :project_memberships, id: :uuid do |t|
      t.string      :job_title
      t.datetime    :join_date
      t.boolean     :invitation_accepted,   null: false, default: true
      t.references  :user,                  null: false, foreign_key: true, type: :uuid
      t.references  :project,               null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :project_memberships, :invitation_accepted
  end
end
