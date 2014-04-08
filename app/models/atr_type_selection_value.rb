class AtrTypeSelectionValue < ActiveRecord::Base
  self.table_name = 'atr_type_selection_value'

  def readonly?
    true
  end
end
