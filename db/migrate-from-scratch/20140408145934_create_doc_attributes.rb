class CreateDocAttributes < ActiveRecord::Migration
  def change
    create_table :doc_attribute, :primary_key => 'doc_attribute' do |t|
      t.integer :atr_type_selection_value_fk
      t.integer :doc_attribute_type_fk
      t.integer :document_fk
      t.string :type_name
      t.string :value_text
      t.decimal :value_number
      t.date :value_date
      t.integer :data_type
      t.integer :orderby
      t.string :required, limit: 1
    end
  end
end
