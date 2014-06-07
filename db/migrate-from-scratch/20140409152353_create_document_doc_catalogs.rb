class CreateDocumentDocCatalogs < ActiveRecord::Migration
  def change
    create_table :document_doc_catalog, :primary_key => 'document_doc_catalog' do |t|
      t.integer :document_fk
      t.integer :doc_catalog_fk
      t.timestamp :catalog_time
    end
  end
end
