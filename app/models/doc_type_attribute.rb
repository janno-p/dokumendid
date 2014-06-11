# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class DocTypeAttribute < ActiveRecord::Base
  self.table_name = "doc_type_attribute"
  self.primary_key = "doc_type_attribute"

  default_scope { order("orderby") }

  belongs_to :doc_type, foreign_key: "doc_type_fk"
  belongs_to :doc_attribute_type, foreign_key: "doc_attribute_type_fk"

  def attribute_id
    self.doc_type_attribute
  end

  def data_type_id
    self.doc_attribute_type.data_type_fk
  end

  def to_doc_attribute(value)
    doc_attribute = {
      atr_type_selection_value_fk: nil,
      doc_attribute_type: self.doc_attribute_type,
      type_name: self.doc_attribute_type.type_name,
      value_text: nil,
      value_number: nil,
      value_date: nil,
      data_type: self.doc_attribute_type.data_type_fk,
      orderby: self.orderby,
      required: self.required,
    }
    if data_type = 4 and not self.doc_attribute_type.default_selection_id_fk.nil? then
      doc_attribute[:atr_type_selection_value_fk] = self.doc_attribute_type.default_selection_id_fk
    end
    if data_type = 2 and not self.doc_attribute_type.default_value_text.nil? then
      doc_attribute[:value_text] = self.doc_attribute_type.default_value_text
    end
    unless value.nil? then
      value_mapping = { 1 => :value_text,
                        2 => :value_number,
                        3 => :value_date,
                        4 => :atr_type_selection_value_fk }
      doc_attribute[value_mapping[self.doc_attribute_type.data_type_fk]] = value
    end
    doc_attribute
  end
end
