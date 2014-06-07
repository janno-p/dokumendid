class CreatePeople < ActiveRecord::Migration
  def change
    create_table :person, :primary_key => 'person' do |t|
      t.string :first_name, limit: 100
      t.string :last_name, limit: 100
      t.string :identity_code, limit: 20
      t.date :birth_date
      t.integer :created_by
      t.integer :updated_by
      t.timestamp :created
      t.timestamp :updated
    end
  end
end
