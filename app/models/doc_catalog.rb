class DocCatalog < ActiveRecord::Base
  self.table_name = "doc_catalog"
  self.primary_key = "doc_catalog"

  has_many :doc_catalogs, foreign_key: "upper_catalog_fk"
end
