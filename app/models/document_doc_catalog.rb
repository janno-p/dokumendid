class DocumentDocCatalog < ActiveRecord::Base
  self.table_name = "document_doc_catalog"
  self.primary_key = "document_doc_catalog"

  belongs_to :document, foreign_key: "document_fk"
  belongs_to :doc_catalog, foreign_key: "doc_catalog_fk"

  attr_accessor :current_user

  after_create do
    doc_catalog.content_updated = DateTime.now
    doc_catalog.content_updated_by = current_user.employee.employee
    doc_catalog.save
  end

  after_destroy do
    doc_catalog.content_updated = DateTime.now
    doc_catalog.content_updated_by = current_user.employee.employee
    doc_catalog.save
  end
end
