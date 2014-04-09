class DocType < ActiveRecord::Base
  self.table_name = 'doc_type'

  def readonly?
    true
  end
end
