class DocStatus < ActiveRecord::Base
  self.table_name = "doc_status"
  self.primary_key = "doc_status"

  belongs_to :doc_status_type, foreign_key: "doc_status_type_fk"
end
