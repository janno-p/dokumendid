# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class DocStatus < ActiveRecord::Base
  self.table_name = "doc_status"
  self.primary_key = "doc_status"

  belongs_to :doc_status_type, foreign_key: "doc_status_type_fk"
end
