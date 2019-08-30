class Roles < ActiveRecord::Migration[5.2]
  def up
    create_table :roles do |t|
      t.string 'role_name'
      t.timestamps
    end
  end

  def down
    drop_table :roles
  end
end
