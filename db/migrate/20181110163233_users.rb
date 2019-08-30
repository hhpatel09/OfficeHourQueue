class Users < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :picture
      t.string :session_token
      t.references 'role', foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
