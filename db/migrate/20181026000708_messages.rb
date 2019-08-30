class Messages < ActiveRecord::Migration[5.2]
  def up
    create_table :messages do |t|
      t.string :message_text
      t.datetime :time
      t.references :user, foreign_key: true
      t.references :office_hours_session, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
