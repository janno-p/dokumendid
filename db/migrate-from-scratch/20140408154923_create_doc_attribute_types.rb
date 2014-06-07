class CreateDocAttributeTypes < ActiveRecord::Migration
  def change
    create_table :doc_attribute_type, :primary_key => 'doc_attribute_type' do |t|
      t.integer :default_selection_id_fk
      t.string :type_name
      t.string :default_value_text
      t.integer :data_type_fk
      t.string :multiple_attributes, limit: 1

      t.timestamps
    end
  end
end
