module DocumentsHelper
  def document_attribute(attribute)
    capture_haml do
      case attribute.data_type
      when 1 then document_attribute_text(attribute, :value_text)
      when 2 then document_attribute_text(attribute, :value_number)
      when 3 then document_attribute_text(attribute, :value_date)
      when 4 then document_attribute_select(attribute, :atr_type_selection_value_fk)
      else raise "Unknown attribute type: #{attribute.data_type}"
      end
    end
  end

  private
    def document_attribute_text(attribute, property)
      haml_tag :div, class: "form-group" do
        haml_concat (attribute_label_tag attribute)
        haml_tag :div, class: "col-sm-5" do
          haml_concat (attribute_text_field_tag attribute, property)
        end
      end
    end

    def document_attribute_select(attribute, property)
      haml_tag :div, class: "form-group" do
        haml_concat (attribute_label_tag attribute)
        haml_tag :div, class: "col-sm-5" do
          haml_concat (attribute_select_tag attribute, property)
        end
      end
    end

    def attribute_label_tag(attribute)
      label_tag (attribute_name attribute), class: "col-sm-3 control-label" do
        "#{attribute.doc_attribute_type.type_name.capitalize}: "
      end
    end

    def attribute_text_field_tag(attribute, property)
      name = attribute_name attribute
      value = attribute[property]
      options = { class: "form-control", placeholder: placeholder_for(property) }
      text_field_tag name, value, options
    end

    def attribute_select_tag(attribute, property)
      collection = attribute.doc_attribute_type.atr_type_selection_values
      options = options_from_collection_for_select(collection, :atr_type_selection_value, :value_text, attribute[property])
      select_tag (attribute_name attribute), options, class: "form-control"
    end

    def attribute_name(attribute)
      "document[attributes][#{attribute.doc_attribute}]"
    end

    def placeholder_for(property)
      case property
      when :value_text then 'Mingi tekst'
      when :value_number then 12345
      when :value_date then 'PP.KK.AAAA'
      end
    end
end
