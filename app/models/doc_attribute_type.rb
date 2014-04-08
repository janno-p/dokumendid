class DocAttributeType < ActiveRecord::Base
  self.table_name = 'doc_attribute_type'

  def readonly?
    true
  end
end
