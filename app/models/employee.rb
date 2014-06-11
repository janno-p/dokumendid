# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class Employee < ActiveRecord::Base
  self.table_name = "employee"
  self.primary_key = "employee"

  belongs_to :person, foreign_key: "person_fk"

  def readonly?
    true
  end
end
