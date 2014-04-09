class CreateEnterprises < ActiveRecord::Migration
  def change
    create_table :enterprise, :primary_key => 'enterprise' do |t|
      t.string :name
      t.string :full_name
      t.integer :created_by
      t.integer :updated_by
      t.timestamp :created
      t.timestamp :updated
    end
  end
end
