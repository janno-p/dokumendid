class Enterprise < ActiveRecord::Base
  self.table_name = 'enterprise'

  def readonly?
    true
  end
end
