class Employee < ActiveRecord::Base
  self.table_name = 'employee'

  def readonly?
    true
  end
end
