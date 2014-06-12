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

  def self.simple_qry(documents, name, value)
    value.present? ? documents.where("#{name} = ?", value) : documents
  end

  def self.simple_text_qry(documents, name, value)
    value.present? ? documents.where("LOWER(#{name}) LIKE LOWER(?)", "#{value}%") : documents
  end

  def self.full_text_qry(documents, name, value)
    value.present? ? documents.where("TO_TSVECTOR(#{name}) @@ PLAINTO_TSQUERY(?)", value) : documents
  end

  def self.of_user_qry(documents, value)
    value.present? ? documents.joins(employee: :person).where('LOWER("person"."last_name") LIKE LOWER(?)', "#{value}%") : documents
  end

  def self.general_attribute_qry(documents, value)
    if value.present? then
      documents.joins(:doc_attributes).where(
        '("doc_attribute"."data_type" = 1 AND POSITION(LOWER(?) IN LOWER("doc_attribute"."value_text")) > 0) OR ' +
        '("doc_attribute"."data_type" = 2 AND POSITION(? IN \'\' || "doc_attribute"."value_number") > 0) OR ' +
        '("doc_attribute"."data_type" = 3 AND POSITION(? IN TO_CHAR("doc_attribute"."value_date", \'DD.MM.YYYY\')) > 0) OR ' +
        '("doc_attribute"."data_type" = 4 AND POSITION(LOWER(?) IN (SELECT LOWER("atr_type_selection_value"."value_text") FROM "atr_type_selection_value" WHERE "atr_type_selection_value"."atr_type_selection_value" = "doc_attribute"."atr_type_selection_value_fk")) > 0)',
          value, value, value, value)
    else
      documents
    end
  end
end
