# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

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
