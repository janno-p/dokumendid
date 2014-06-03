class DocCatalog < ActiveRecord::Base
  self.table_name = "doc_catalog"
  self.primary_key = "doc_catalog"

  has_many :doc_catalogs, foreign_key: "upper_catalog_fk"
  belongs_to :doc_catalog, foreign_key: "upper_catalog_fk"

  has_many :document_doc_catalogs, foreign_key: "doc_catalog_fk"
  has_many :documents, through: :document_doc_catalogs
end
