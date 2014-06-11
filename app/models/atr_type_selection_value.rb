# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class AtrTypeSelectionValue < ActiveRecord::Base
  self.primary_key = "atr_type_selection_value"
  self.table_name = "atr_type_selection_value"

  default_scope { order("orderby") }

  def readonly?
    true
  end
end
