# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class Enterprise < ActiveRecord::Base
  self.table_name = 'enterprise'

  def readonly?
    true
  end
end
