class DocAttributeType < ActiveRecord::Base
  self.table_name = "doc_attribute_type"
  self.primary_key = "doc_attribute_type"

  has_many :atr_type_selection_values, foreign_key: "doc_attribute_type_fk"

  def readonly?
    true
  end
end
