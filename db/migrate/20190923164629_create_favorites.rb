class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :job, foreign_key: true
      t.string :organization
      t.string :title
      t.boolean :done

      t.timestamps
    end
  end
end
