class DocAttribute < ActiveRecord::Base
  DATA_TYPE_TEXT = 1
  DATA_TYPE_NUMBER = 2
  DATA_TYPE_DATE = 3
  DATA_TYPE_CHOICE = 4

  VALUE_MAPPINGS = { DATA_TYPE_TEXT => :value_text,
                     DATA_TYPE_NUMBER => :value_number,
                     DATA_TYPE_DATE => :value_date,
                     DATA_TYPE_CHOICE => :atr_type_selection_value_fk }

  self.table_name = "doc_attribute"
  self.primary_key = "doc_attribute"

  default_scope { order("orderby") }

  belongs_to :doc_attribute_type, foreign_key: "doc_attribute_type_fk"

  attr_accessor :doc_type_attribute
  attr_accessor :value

  def value
    if @value.nil? then
      case data_type
      when DATA_TYPE_TEXT then
        value_text
      when DATA_TYPE_NUMBER then
        value_number.to_s if value_number
      when DATA_TYPE_DATE then
        value_date.strftime("%d.%m.%Y") if value_date
      end
    else
      @value
    end
  end

  def value=(v)
    @value = v
    case data_type
    when DATA_TYPE_TEXT then
      self.value_text = v
    when DATA_TYPE_NUMBER then
      self.value_number = v.to_f rescue nil
    when DATA_TYPE_DATE then
      self.value_date = Date.strptime(v, "%d.%m.%Y") rescue nil
    end
  end

  validate :presence_when_required

  def presence_when_required
    if required.upcase == "Y" and (self.value.nil? or self.value.to_s.blank?) then
      errors.add(:base, "Atribuut \"#{type_name.downcase}\" on kohustuslik.")
    elsif data_type == 2 and not value =~ /\A[+-]?\d+(\.\d*)?\Z/ then
      errors.add(:base, "Atribuudi \"#{type_name.downcase}\" väärtus peab olema arv.")
    elsif data_type == 3 and not value.blank? then
      date_value = Date.strptime(value, "%d.%m.%Y") rescue nil
      if date_value.nil? or date_value.year > 9999 then
        errors.add(:base, "Atribuudi \"#{type_name.downcase}\" väärtus peab olema korrektne kuupäev kujul \"pp.kk.aaaa\".")
      end
    end
  end
end
