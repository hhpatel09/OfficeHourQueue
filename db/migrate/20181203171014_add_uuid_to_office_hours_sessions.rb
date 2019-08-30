class AddUuidToOfficeHoursSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :office_hours_sessions, :uuid, :string
  end
end
