class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :organization
      t.string :address
      t.string :title
      t.string :description
      t.integer :duration

      t.timestamps
    end
  end
end
