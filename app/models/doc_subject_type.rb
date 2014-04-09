class DocSubjectType < ActiveRecord::Base
  self.table_name = 'doc_subject_type'

  def readonly?
    true
  end
end
