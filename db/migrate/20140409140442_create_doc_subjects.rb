class CreateDocSubjects < ActiveRecord::Migration
  def change
    create_table :doc_subject, :primary_key => 'doc_subject' do |t|
      t.integer :doc_subject_relation_type_fk
      t.integer :doc_subject_type_fk
      t.integer :document_fk
      t.integer :subject_fk
      t.string :note
    end
  end
end
