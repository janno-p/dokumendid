class Person < ActiveRecord::Base
  self.table_name = "person"
  self.primary_key = "person"

  def readonly?
    true
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
