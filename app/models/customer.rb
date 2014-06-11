# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class Customer < ActiveRecord::Base
  self.table_name = 'customer'

  def readonly?
    true
  end
end
