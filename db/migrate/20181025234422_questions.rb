class Questions < ActiveRecord::Migration[5.2]
  def up
    create_table :questions do |t|
      t.string :question_text
      t.datetime :time_added
      t.datetime :time_started
      t.datetime :time_completed
      t.references :student, foreign_key: true
      t.references :instructor, foreign_key: true
      t.references :course, foreign_key: true
      t.references :office_hours_session, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :questions
  end
end
