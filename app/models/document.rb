class Document < ActiveRecord::Base
  self.table_name = "document"
  self.primary_key = "document"

  has_one :document_doc_catalog, foreign_key: "document_fk"
  has_one :doc_catalog, through: :document_doc_catalog

  has_one :document_doc_type, foreign_key: "document_fk"
  has_one :doc_type, through: :document_doc_type

  has_many :doc_attributes, foreign_key: "document_fk"
end
