class CreateWorkspaces < ActiveRecord::Migration[7.0]
  def change
    create_table :workspaces do |t|
      t.string :name, null: false
      t.text :description
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
