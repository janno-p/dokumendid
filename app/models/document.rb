# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class Document < ActiveRecord::Base
  self.table_name = "document"
  self.primary_key = "document"

  has_one :document_doc_catalog, foreign_key: "document_fk", dependent: :destroy
  has_one :doc_catalog, through: :document_doc_catalog

  has_one :document_doc_type, foreign_key: "document_fk", dependent: :destroy
  has_one :doc_type, through: :document_doc_type

  has_many :doc_attributes, foreign_key: "document_fk", dependent: :destroy

  belongs_to :doc_status_type, foreign_key: "doc_status_type_fk"
  has_many :doc_statuses, foreign_key: "document_fk", dependent: :destroy

  belongs_to :employee, foreign_key: "updated_by"

  validates :name, presence: { message: "Dokumendi nimetus on kohustuslik märkida." },
                   length: { maximum: 150, message: "Dokumendi nimetus võib olla maksimaalselt 150 tähemärki." }
  validates :doc_type, presence: { message: "Dokumendi tüüp on kohustuslik märkida." }
  validates :doc_status_type, presence: { message: "Dokumendi staatuse määramine on kohustuslik." }

  validates_associated :doc_attributes

  attr_accessor :current_user

  def full_path
    doc_catalog.full_path + "/#{name}"
  end

  before_save do
    current_status = doc_statuses.find_by_status_end(nil)
    if current_status.nil? or not current_status.doc_status_type_fk == doc_status_type_fk then
      now = DateTime.now
      current_status.update_attributes({ status_end: now }) if current_status
      doc_statuses.build({ doc_status_type_fk: doc_status_type_fk,
                           status_begin: now,
                           created_by: current_user.employee.employee })
    end
  end

  def self.delete_sp(document, user)
    self.connection.execute("SELECT delete_document(#{document.document}, #{user.user_account})")
  end
end
