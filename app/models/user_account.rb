class UserAccount < ActiveRecord::Base
  self.table_name = 'user_account'

  def readonly?
    true
  end
end
