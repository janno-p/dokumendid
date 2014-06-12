# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class SearchController < ApplicationController
  def index
    @root = DocCatalog.root
    @doc_status_types = DocStatusType.order(:type_name).all
    @doc_types = DocType.joins(:doc_types).where('"doc_type"."level" = 1').uniq.all
  end

  def results
    @root = DocCatalog.root
    @doc_status_types = DocStatusType.order(:type_name).all
    @doc_types = DocType.joins(:doc_types).where('"doc_type"."level" = 1').uniq.all

    documents = Document.order(:name)
    criteria = SearchCriteria.new(params[:document])

    documents = Document.simple_qry(documents, "document", params[:document][:id])
    documents = Document.simple_text_qry(documents, "name", params[:document][:name])
    documents = Document.full_text_qry(documents, "description", params[:document][:description])
    documents = Document.of_user_qry(documents, params[:document][:updated_by])
    documents = Document.of_catalog_qry(documents, params[:document][:catalog])
    documents = Document.simple_qry(documents, "doc_status_type_fk", params[:document][:status])
    if params[:document][:type].present? then
      documents = Document.of_type_qry(documents, params[:document][:type])
      @attributes = DocTypeAttribute.where("doc_type_fk = ?", params[:document][:type].to_i)
      has_join = false
      @attributes.each do |attribute|
        value = params[:document][:attribute][attribute.doc_type_attribute.to_s]
        if value.present? and not has_join then
          documents = documents.joins(:doc_attributes)
          has_join = true
        end
        documents = Document.attribute_qry(documents, attribute, value)
      end
    else
      documents = Document.general_attribute_qry(documents, params[:document][:attribute_value])
    end

    result_set = documents.distinct.map do |d|
      { doc: d, path: edit_document_path(d) }
    end

    documents_xml = Nokogiri::XML(result_set.to_xml)
    template = Nokogiri::XSLT(File.read(File.join(Rails.root, "app", "views", "search", "documents.xslt")))

    @content = template.transform(documents_xml).to_s

    #render plain: @content
    #render plain: documents_xml

    render action: :index
  end
end
