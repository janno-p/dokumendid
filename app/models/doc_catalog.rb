# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class DocCatalog < ActiveRecord::Base
  self.table_name = "doc_catalog"
  self.primary_key = "doc_catalog"

  default_scope { order("doc_catalog") }

  has_many :doc_catalogs, foreign_key: "upper_catalog_fk"
  belongs_to :doc_catalog, foreign_key: "upper_catalog_fk"

  has_many :document_doc_catalogs, foreign_key: "doc_catalog_fk"
  has_many :documents, through: :document_doc_catalogs

  belongs_to :employee, foreign_key: "content_updated_by"

  def full_path
    (doc_catalog.nil? ? "/" : "#{doc_catalog.full_path}/") + name
  end

  def self.root
    self.new do |catalog|
      catalog.id = 0
      catalog.name = "DOKUMENDID"
      catalog.doc_catalogs = self.where("upper_catalog_fk = ?", 0)
    end
  end
end
