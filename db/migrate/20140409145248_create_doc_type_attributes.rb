class CreateDocTypeAttributes < ActiveRecord::Migration
  def change
    create_table :doc_type_attribute, :primary_key => 'doc_type_attribute' do |t|
      t.integer :doc_attribute_type_fk
      t.integer :doc_type_fk
      t.integer :orderby
      t.string :required, limit: 1
      t.string :created_by_default, limit: 1
    end
  end
end
