# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class DocSubjectRelationType < ActiveRecord::Base
  self.table_name = 'doc_subject_relation_type'

  def readonly?
    true
  end
end
