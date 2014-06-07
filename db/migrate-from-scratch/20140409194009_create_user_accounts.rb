class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_account, :primary_key => 'user_account' do |t|
      t.integer :subject_type_fk
      t.integer :subject_fk
      t.string :username, limit: 50
      t.string :passw, limit: 300
      t.integer :status
      t.date :valid_from
      t.date :valid_to
      t.integer :created_by
      t.timestamp :created
      t.string :password_never_expires, limit: 1
    end
  end
end
