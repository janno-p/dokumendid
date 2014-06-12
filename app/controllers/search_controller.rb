class SearchController < ApplicationController
  def index
    @root = DocCatalog.root
    @doc_status_types = DocStatusType.order(:type_name).all
    @doc_types = DocType.joins(:doc_types).where('"doc_type"."level" = 1').uniq.all
  end

  def results
    documents = Document.order(:name)
    documents = Document.simple_qry(documents, "document", params[:document][:id])
    documents = Document.simple_text_qry(documents, "name", params[:document][:name])
    documents = Document.full_text_qry(documents, "description", params[:document][:description])
    documents = Document.of_user_qry(documents, params[:document][:updated_by])
    documents = Document.of_catalog_qry(documents, params[:document][:catalog])
    documents = Document.simple_qry(documents, "doc_status_type_fk", params[:document][:status])
    if params[:document][:type].present? then
      documents = Document.of_type_qry(documents, params[:document][:type])
      @attributes = DocTypeAttribute.where("doc_type_fk = ?", params[:document][:type].to_i)
    else
      documents = Document.general_attribute_qry(documents, params[:document][:attribute_value])
    end
    render xml: documents.distinct
  end

  def attributes
  end
end
