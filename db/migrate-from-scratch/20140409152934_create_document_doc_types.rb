class CreateDocumentDocTypes < ActiveRecord::Migration
  def change
    create_table :document_doc_type, :primary_key => 'document_doc_type' do |t|
      t.integer :doc_type_fk
      t.integer :document_fk
    end
  end
end
