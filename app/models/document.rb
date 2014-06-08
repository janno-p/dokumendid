class Document < ActiveRecord::Base
  self.table_name = "document"
  self.primary_key = "document"

  has_one :document_doc_catalog, foreign_key: "document_fk"
  has_one :doc_catalog, through: :document_doc_catalog

  has_one :document_doc_type, foreign_key: "document_fk"
  has_one :doc_type, through: :document_doc_type

  has_many :doc_attributes, foreign_key: "document_fk"

  belongs_to :doc_status_type, foreign_key: "doc_status_type_fk"
  has_many :doc_statuses, foreign_key: "document_fk"

  belongs_to :employee, foreign_key: "updated_by"

  validates :name, presence: { message: "Dokumendi nimetus on kohustuslik märkida." },
                   length: { maximum: 150, message: "Dokumendi nimetus võib olla maksimaalselt 150 tähemärki." }
  validates :doc_type, presence: { message: "Dokumendi tüüp on kohustuslik märkida." }
  validates :doc_status_type, presence: { message: "Dokumendi staatuse määramine on kohustuslik." }

  validates_associated :doc_attributes
end
