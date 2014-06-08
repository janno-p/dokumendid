class DocType < ActiveRecord::Base
  self.table_name = "doc_type"
  self.primary_key = "doc_type"

  default_scope { order("type_name") }

  has_many :doc_types, foreign_key: "super_type_fk"
  belongs_to :doc_type, foreign_key: "super_type_fk"

  has_many :doc_type_attributes, foreign_key: "doc_type_fk"

  #def readonly?
  #  true
  #end
end
