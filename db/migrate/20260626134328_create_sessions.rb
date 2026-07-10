class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.references :authenticatable,
                   polymorphic: true,
                   null: false,
                   index: true

      t.string :token, null: false
      t.string :ip_address
      t.string :user_agent
      t.datetime :last_seen_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
