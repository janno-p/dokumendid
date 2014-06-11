# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class ClipboardController < ApplicationController
  before_filter :check_if_xhr

  def add
    document = Document.find(params[:id]) rescue nil
    session[:buffer] << document.document unless document.nil?
    session[:buffer].uniq!
    render json: "ok"
  end

  def remove
    session[:buffer].delete params[:id].to_i
    render json: "ok"
  end

  def index
    @current_catalog = DocCatalog.find(params[:catalog]) rescue nil
    @documents = Document.where(document: session[:buffer])
  end

  def clear
    session[:buffer] = []
    render json: "ok"
  end

  def paste
    @current_catalog = DocCatalog.find(params[:catalog]) rescue nil
    unless @current_catalog.nil? then
      @documents = Document.where(document: session[:buffer])
      Document.transaction do
        @documents.each do |doc|
          doc.document_doc_catalog.current_user = @current_user
          doc.document_doc_catalog.destroy
          doc.build_document_doc_catalog(doc_catalog: @current_catalog,
                                         catalog_time: DateTime.now,
                                         current_user: @current_user)
          doc.document_doc_catalog.save
        end
      end
      session[:buffer] = []
    end
    render json: { url: catalog_documents_path(@current_catalog) }
  end

  private

  def check_if_xhr
    unless request.xhr? then
      not_found
    else
      session[:buffer] ||= []
    end
  end
end
