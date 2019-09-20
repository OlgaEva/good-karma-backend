class CreateVolunteers < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteers do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :job, foreign_key: true

      t.timestamps
    end
  end
end
