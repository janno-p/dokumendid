class CreateDocSubjectRelationTypes < ActiveRecord::Migration
  def change
    create_table :doc_subject_relation_type, :primary_key => 'doc_subject_relation_type' do |t|
      t.string :type_name, limit: 200
    end
  end
end
