class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customer, :primary_key => 'customer' do |t|
      t.integer :subject_fk
      t.integer :subject_type_fk
    end
  end
end
