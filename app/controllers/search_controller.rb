# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

class SearchController < ApplicationController
  before_filter :load_context

  def index
    @criteria = SearchCriteria.new({})
  end

  def results
    @criteria = SearchCriteria.new(params[:document])
    result_set = Document.search_documents(@criteria).map { |d| { doc: d, path: edit_document_path(d) } }

    @current_catalog = DocCatalog.find(@criteria.catalog) rescue nil
    @attributes = DocTypeAttribute.where("doc_type_fk = ?", @criteria.type.to_i)

    documents_xml = Nokogiri::XML(result_set.to_xml)
    template = Nokogiri::XSLT(File.read(File.join(Rails.root, "app", "views", "search", "documents.xslt")))

    @content = template.transform(documents_xml).to_s

    render action: :index
  end

  def load_context
    @root = DocCatalog.root
    @doc_status_types = DocStatusType.order(:type_name).all
    @doc_types = DocType.joins(:doc_types).where('"doc_type"."level" = 1').uniq.all
  end
end
