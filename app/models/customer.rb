class Customer < ActiveRecord::Base
  self.table_name = 'customer'

  def readonly?
    true
  end
end
