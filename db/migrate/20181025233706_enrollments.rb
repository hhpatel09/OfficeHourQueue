class Enrollments < ActiveRecord::Migration[5.2]
  def up
    create_table :enrollments, id: false do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :enrollments
  end
end
