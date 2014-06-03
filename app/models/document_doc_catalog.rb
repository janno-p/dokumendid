class DocumentDocCatalog < ActiveRecord::Base
  self.table_name = "document_doc_catalog"
  self.primary_key = "document_doc_catalog"

  belongs_to :document, foreign_key: "document_fk"
end
