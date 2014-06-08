require 'pp'

class DocumentsController < ApplicationController
  before_filter :load_catalog_context, except: [:attributes]
  before_filter :load_document_context, only: [:new, :edit, :create]

  def index
  end

  def new
    if @current_catalog == @root then
      redirect_to catalog_documents_path(0)
    else
      @document = Document.new
    end
  end

  def create
    if @current_catalog.nil? or @current_catalog == @root then
      redirect_to catalog_documents_path(0)
    else
      doc_type = DocType.find(params[:document][:doc_type].to_i) rescue nil
      @document = Document.new({ name: params[:document][:name],
                                 description: params[:document][:description],
                                 doc_type: doc_type,
                                 doc_status_type_fk: params[:document][:doc_status_type],
                                 created: DateTime.now,
                                 created_by: @current_user.employee.employee,
                                 updated: DateTime.now,
                                 updated_by: @current_user.employee.employee })
      @document.build_document_doc_catalog(doc_catalog: @current_catalog,
                                           catalog_time: DateTime.now,
                                           current_user: @current_user)
      unless doc_type.nil? then
        @document.build_document_doc_type(doc_type: doc_type)
        doc_type.doc_type_attributes.each do |doc_type_attribute|
          value = params[:document][:attributes][doc_type_attribute.doc_type_attribute.to_s]
          attribute = @document.doc_attributes.build(doc_type_attribute.to_doc_attribute(value))
          attribute.doc_type_attribute = doc_type_attribute
          attribute.value = value
        end
      end
      if @document.save then
        redirect_to catalog_documents_path(@current_catalog), notice: "Dokumendi lisamine õnnestus."
      else
        render action: :new
      end
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
