class DataType < ActiveRecord::Base
  self.table_name = 'data_type'

  def readonly?
    true
  end
end
