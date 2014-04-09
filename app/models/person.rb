class Person < ActiveRecord::Base
  self.table_name = 'person'

  def readonly?
    true
  end
end
