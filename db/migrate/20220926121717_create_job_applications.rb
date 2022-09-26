class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.string :title
      t.text :description
      t.string :company
      t.string :job_link
      t.string :status
      t.string :notes
      t.belongs_to :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
