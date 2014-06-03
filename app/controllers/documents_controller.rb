class DocumentsController < ApplicationController
  def index
    @catalogs = DocCatalog.where("upper_catalog_fk = ?", 0)
    @current_catalog = DocCatalog.find_by_name "teabenouded"
  end
end
