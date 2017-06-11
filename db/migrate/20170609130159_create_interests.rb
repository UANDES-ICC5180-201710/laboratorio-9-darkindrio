class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.integer :student_id
      t.integer :curse_id

      t.timestamps
    end
  end
end
