class OfficeHoursSessions < ActiveRecord::Migration[5.2]
  def up
    create_table :office_hours_sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :course, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :office_hours_sessions
  end
end
