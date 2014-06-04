class DocumentsController < ApplicationController
  def index
    @root = DocCatalog.root
    @current_catalog = params[:catalog_id].to_i == 0 ? @root : DocCatalog.find(params[:catalog_id])
  end

  def new
    if params[:catalog_id].to_i == 0 then
      redirect_to catalog_documents_path(0)
    else
      @root = DocCatalog.root
      @document = Document.new
      @current_catalog = params[:catalog_id].to_i == 0 ? @root : DocCatalog.find(params[:catalog_id])
    end
  end

  def edit
    @root = DocCatalog.root
    @document = Document.find(params[:id])
    @current_catalog = @document.doc_catalog
  end
end
