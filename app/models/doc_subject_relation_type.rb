class DocSubjectRelationType < ActiveRecord::Base
  self.table_name = 'doc_subject_relation_type'

  def readonly?
    true
  end
end
