class DocStatusType < ActiveRecord::Base
  self.table_name = "doc_status_type"
  self.primary_key = "doc_status_type"

  def readonly?
    true
  end
end
