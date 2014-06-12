class SearchCriteria
  include ActiveModel::Serializers::Xml

  ACCESSORS = [:id, :name, :description, :updated_by, :catalog, :status, :type, :attribute, :attribute_value]

  attr_accessor *ACCESSORS

  def initialize(args)
    SearchCriteria::ACCESSORS.each do |acc|
      self.send("#{acc}=", args[acc]) if args[acc].present?
    end
  end

  def attributes
    accessors = {}
    SearchCriteria::ACCESSORS.each do |acc|
      val = self.send(acc)
      accessors[acc.to_s] = nil if val.present?
    end
    accessors
  end
end
