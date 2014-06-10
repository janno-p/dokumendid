class ClipboardController < ApplicationController
  before_filter :check_if_xhr

  def add
    session[:buffer] ||= []
    document = Document.find(params[:id]) rescue nil
    session[:buffer] << document.document unless document.nil?
    session[:buffer].uniq!
    render json: "ok"
  end

  def remove
    session[:buffer] ||= []
    session[:buffer].delete params[:id].to_i
    render json: "ok"
  end

  private

  def check_if_xhr
    unless request.xhr? then
      not_found
    end
  end
end
