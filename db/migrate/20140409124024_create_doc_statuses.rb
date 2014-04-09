class CreateDocStatuses < ActiveRecord::Migration
  def change
    create_table :doc_statuse, :primary_key => 'doc_status' do |t|
      t.integer :document_fk
      t.integer :doc_status_type_fk
      t.timestamp :status_begin
      t.timestamp :status_end
      t.integer :created_by
    end
  end
end
