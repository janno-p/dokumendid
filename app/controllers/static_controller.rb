# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class StaticController < ApplicationController
  def log
    render text: File.read(File.join(Rails.root, "log", "#{Rails.env}.log")), content_type: "text/plain"
  end
end
