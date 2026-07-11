class CreateOtps < ActiveRecord::Migration[8.0]
  def change
    create_table :otps do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code_digest, null: false
      t.datetime :expires_at, null: false
      t.datetime :verified_at
      t.integer :attempts, default: 0, null: false
      t.timestamps
    end
  end
end
