class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :messenger_id
      t.integer :messagee_id
      t.string :message
      t.integer :job_id

      t.timestamps
    end
  end
end
