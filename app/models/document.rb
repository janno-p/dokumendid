class Document < ActiveRecord::Base
  self.table_name = "document"
  self.primary_key = "document"

  has_one :document_doc_catalog, foreign_key: "document_fk"
  has_one :doc_catalog, through: :document_doc_catalog
end
