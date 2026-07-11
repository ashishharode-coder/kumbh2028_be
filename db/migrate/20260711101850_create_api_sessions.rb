class CreateApiSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :api_sessions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :token, null: false

      t.string :device_id
      t.string :device_name
      t.string :platform

      t.string :ip_address

      t.datetime :last_seen_at

      t.datetime :expires_at

      t.timestamps
    end
    add_index :api_sessions, :token, unique: true
  end
end
