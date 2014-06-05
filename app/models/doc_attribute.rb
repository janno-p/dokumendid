class DocAttribute < ActiveRecord::Base
  self.table_name = "doc_attribute"
  self.primary_key = "doc_attribute"

  default_scope { order("orderby") }

  belongs_to :doc_attribute_type, foreign_key: "doc_attribute_type_fk"
end
