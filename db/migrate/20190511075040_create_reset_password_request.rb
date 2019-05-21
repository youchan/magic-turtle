class CreateResetPasswordRequest < ActiveRecord::Migration[5.2]
  def change
    create_table :reset_password_requests do |t|
      t.string :guid
      t.string :account_guid, null: false
      t.string :status

      t.timestamps
    end
  end
end
