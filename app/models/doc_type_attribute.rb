class DocTypeAttribute < ActiveRecord::Base
  self.table_name = "doc_type_attribute"
  self.primary_key = "doc_type_attribute"

  default_scope { order("orderby") }

  belongs_to :doc_type, foreign_key: "doc_type_fk"
  belongs_to :doc_attribute_type, foreign_key: "doc_attribute_type_fk"

  def attribute_id
    self.doc_type_attribute
  end

  def data_type_id
    self.doc_attribute_type.data_type_fk
  end
end
