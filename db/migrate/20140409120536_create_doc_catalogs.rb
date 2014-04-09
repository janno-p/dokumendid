class CreateDocCatalogs < ActiveRecord::Migration
  def change
    create_table :doc_catalog, :primary_key => 'doc_catalog' do |t|
      t.integer :catalog_owner_fk
      t.integer :doc_catalog_type_fk
      t.string :name
      t.string :description
      t.integer :level
      t.timestamp :content_updated
      t.integer :content_updated_by
      t.integer :upper_catalog_fk
      t.string :folder
    end
  end
end
