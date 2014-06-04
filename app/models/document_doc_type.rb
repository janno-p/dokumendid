class DocumentDocType < ActiveRecord::Base
  self.table_name = "document_doc_type"
  self.primary_key = "document_doc_type"

  belongs_to :document, foreign_key: "document_fk"
  belongs_to :doc_type, foreign_key: "doc_type_fk"
end
