class FormsController < ApplicationController
  #before_filter :check_if_xhr
  protect_from_forgery :except => :attributes

  def attributes
    @attributes = DocTypeAttribute.where("doc_type_fk = ?", params[:doc_type].to_i)
    case params[:form_name]
    when "search"
      render "forms/search_attributes.js.coffee"
    when "new"
      not_found
    else
      not_found
    end
  end

  def check_if_xhr
    unless request.xhr? then
      not_found
    end
  end
end
