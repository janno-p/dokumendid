class Employee < ActiveRecord::Base
  self.table_name = "employee"
  self.primary_key = "employee"

  belongs_to :person, foreign_key: "person_fk"

  def readonly?
    true
  end
end
