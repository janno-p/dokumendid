class CreateDataTypes < ActiveRecord::Migration
  def change
    create_table :data_type, :primary_key => 'data_type' do |t|
      t.string :type_name, limit: 200
    end
  end
end
