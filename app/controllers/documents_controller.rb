class DocumentsController < ApplicationController
  before_filter :load_catalog_context, except: [:attributes]
  before_filter :load_document_context, only: [:new, :edit]

  def index
  end

  def new
    if params[:catalog_id].to_i == 0 then
      redirect_to catalog_documents_path(0)
    else
      @document = Document.new
    end
  end

  def edit
    @document = Document.find(params[:id])
    @current_catalog = @document.doc_catalog
  end

  def attributes
    if request.xhr?
      @doc_type = DocType.find(params[:id])
    else
      not_found
    end
  end

  private

  def load_catalog_context
    @root = DocCatalog.root
    @current_catalog = params[:catalog_id].to_i == 0 ? @root : DocCatalog.find(params[:catalog_id])
  end

  def load_document_context
    @document_types = DocType.joins(:doc_types).where('"doc_type"."level" = 1').uniq.all
    @doc_status_types = DocStatusType.order(:type_name).all
  end
end
