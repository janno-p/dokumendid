class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :document, :primary_key => 'document' do |t|
      t.string :doc_nr
      t.string :name
      t.string :description
      t.timestamp :created
      t.integer :created_by
      t.timestamp :updated
      t.integer :updated_by
      t.integer :doc_status_type_fk
      t.string :filename
    end
  end
end
