class AtrTypeSelectionValue < ActiveRecord::Base
  self.primary_key = 'atr_type_selection_value'
  self.table_name = 'atr_type_selection_value'

  def readonly?
    true
  end
end
