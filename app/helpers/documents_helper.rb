module DocumentsHelper
  def document_attribute(attribute, id_field)
    case attribute.doc_attribute_type.data_type_fk
    when 1 then doc_attribute_text(attribute, id_field, :value_text)
    when 2 then doc_attribute_text(attribute, id_field, :value_number)
    when 3 then doc_attribute_text(attribute, id_field, :value_date)
    when 4 then doc_attribute_select(attribute, id_field, :atr_type_selection_value_fk)
    else raise "Unknown attribute type: #{attribute.data_type}"
    end
  end

  private

  def doc_attribute_name(attribute, id_field)
    "document[attributes][#{attribute[id_field]}]"
  end

  def doc_attribute_placeholder_for(property)
    case property
    when :value_text then 'Mingi tekst'
    when :value_number then 12345
    when :value_date then 'PP.KK.AAAA'
    end
  end

  def doc_attribute_label(attribute, name)
    label_tag name, class: "col-sm-3 control-label" do
      "#{attribute.doc_attribute_type.type_name.capitalize}: "
    end
  end

  def doc_attribute_text(attribute, id_field, property)
    doc_attribute_control attribute, id_field do |name|
      value = attribute[property]
      placeholder = doc_attribute_placeholder_for property
      concat text_field_tag(name, value, class: "form-control", placeholder: placeholder)
    end
  end

  def doc_attribute_select(attribute, id_field, property)
    doc_attribute_control attribute, id_field do |name|
      collection = attribute.doc_attribute_type.atr_type_selection_values
      options = options_from_collection_for_select(collection, :atr_type_selection_value, :value_text, attribute[property])
      select_tag name, options, include_blank: true, class: "form-control"
    end
  end

  def doc_attribute_control(attribute, id_field)
    content_tag :div, class: "form-group" do
      name = doc_attribute_name attribute, id_field
      label_html = doc_attribute_label attribute, name
      control_html = content_tag :div, class: "col-sm-5" do
        yield name
      end
      concat label_html
      concat control_html
    end
  end
end
