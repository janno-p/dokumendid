require 'pp'

class DocumentsController < ApplicationController
  before_filter :load_catalog_context, except: [:attributes, :add_to_buffer, :remove_from_buffer]
  before_filter :load_document_context, only: [:new, :edit, :create, :update]

  def index
    session[:buffer] ||= []
    @buffer = session[:buffer]
    folder_count = @current_catalog.documents.to_a.count { |d| @buffer.include? d.document }
    @buffer_size = @buffer.size - folder_count
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
                                 updated_by: @current_user.employee.employee,
                                 current_user: @current_user })
      @document.build_document_doc_catalog(doc_catalog: @current_catalog,
                                           catalog_time: DateTime.now,
                                           current_user: @current_user)
      unless doc_type.nil? then
        @document.build_document_doc_type(doc_type: doc_type)
        doc_type.doc_type_attributes.each do |doc_type_attribute|
          value = params[:document][:attributes][doc_type_attribute.doc_type_attribute.to_s]
          attribute = @document.doc_attributes.build(doc_type_attribute.to_doc_attribute(value))
          attribute.doc_type_attribute = doc_type_attribute
          attribute.value = value unless value.nil?
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
    @document = Document.find(params[:id]) rescue not_found
    @current_catalog = @document.doc_catalog
  end

  def update
    now = DateTime.now
    @document = Document.find(params[:id]) rescue not_found
    @current_catalog = @document.doc_catalog
    @document.update_attributes({ name: params[:document][:name],
                                  description: params[:document][:description],
                                  doc_status_type_fk: params[:document][:doc_status_type],
                                  updated: now,
                                  updated_by: @current_user.employee.employee,
                                  current_user: @current_user })
    @document.doc_catalog.update_attributes({ content_updated: now,
                                              content_updated_by: @current_user.employee.employee })
    @document.doc_attributes.each do |doc_attribute|
      doc_attribute.update_attributes({ value: params[:document][:attributes][doc_attribute.doc_attribute.to_s] })
    end
    if @document.save then
      redirect_to catalog_documents_path(@current_catalog), notice: "Dokumendi andmed muudetud."
    else
      render action: :edit
    end
  end

  def attributes
    if request.xhr?
      @doc_type = DocType.find(params[:id]) rescue not_found
    else
      not_found
    end
  end

  def destroy
    @document = Document.find(params[:id]) rescue not_found
    @document.document_doc_catalog.current_user = @current_user
    @current_catalog = @document.doc_catalog
    @document.destroy
    redirect_to catalog_documents_path(@current_catalog), notice: "Dokument on kustutatud."
  end

  def add_to_buffer
    if request.xhr? then
      session[:buffer] ||= []
      document = Document.find(params[:id]) rescue nil
      session[:buffer] << document.document unless document.nil?
      session[:buffer].uniq!
      render json: "ok"
    else
      not_found
    end
  end

  def remove_from_buffer
    if request.xhr? then
      session[:buffer] ||= []
      session[:buffer].delete params[:id].to_i
      render json: "ok"
    else
      not_found
    end
  end

  private

  def load_catalog_context
    @root = DocCatalog.root
    if params[:catalog_id].to_i == 0 then
      @current_catalog = @root
    else
      @current_catalog = DocCatalog.find(params[:catalog_id]) rescue not_found
    end
  end

  def load_document_context
    @document_types = DocType.joins(:doc_types).where('"doc_type"."level" = 1').uniq.all
    @doc_status_types = DocStatusType.order(:type_name).all
  end
end
