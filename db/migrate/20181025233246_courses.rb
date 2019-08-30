class Courses < ActiveRecord::Migration[5.2]
  def up
    create_table :courses do |t|
      t.string :department_name
      t.string :course_number
      t.string :course_name
      t.string :semester
      t.timestamps
    end
    add_index :courses, [:department_name, :course_number, :semester], :unique => true, :name => :course_index
  end

  def down
    drop_table :courses
  end
end
