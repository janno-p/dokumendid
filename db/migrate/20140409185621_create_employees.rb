class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employee, :primary_key => 'employee' do |t|
      t.integer :person_fk
      t.integer :enterprise_fk
      t.integer :struct_unit_fk
      t.string :active, limit: 1
    end
  end
end
