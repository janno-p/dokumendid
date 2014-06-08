module DocumentsHelper
  def document_attribute(attribute, id)
    case attribute.data_type_id
    when 1 then doc_attribute_text(attribute, id, :value_text)
    when 2 then doc_attribute_text(attribute, id, :value_number)
    when 3 then doc_attribute_text(attribute, id, :value_date)
    when 4 then doc_attribute_select(attribute, id, :atr_type_selection_value_fk)
    else raise "Unknown attribute type: #{attribute.data_type_id}"
    end
  end

  def bs_doc_attribute(doc_attribute, id_value)
    id = "document_attributes_#{id_value}"
    name = "document[attributes][#{id_value}]"

    options = { errors: doc_attribute.errors[:base] }
    options[:required] = true if doc_attribute.required.upcase == "Y"

    bs_control(id, doc_attribute.type_name.capitalize, options) do
      case doc_attribute.data_type
      when DocAttribute::DATA_TYPE_TEXT, DocAttribute::DATA_TYPE_NUMBER, DocAttribute::DATA_TYPE_DATE then
        tag "input", class: "form-control input-sm", id: id, name: name, type: "text", value: doc_attribute.value
      when DocAttribute::DATA_TYPE_CHOICE then
        collection_key = options[:key] || :id
        collection_value = options[:value] || :value_text
        content_tag(:select, class: "form-control input-sm", id: id, name: name) do
          concat_content_tag :option, value: "" do
          end
          doc_attribute.doc_attribute_type.atr_type_selection_values.each do |value|
            tag_options = { value: value.atr_type_selection_value }
            if value.atr_type_selection_value == doc_attribute.atr_type_selection_value_fk then
              tag_options[:selected] = "selected"
            end
            concat_content_tag :option, tag_options do
              value.value_text
            end
          end
        end
      else
        raise "Unknown attribute type: #{doc_attribute.data_type}"
      end
    end
  end

  def bs_text_field(object, property, text, value, options = {})
    id = object.to_s + "_" + property.to_s
    name = object.to_s + "[" + property.to_s + "]"
    options[:errors] = self.instance_variable_get("@#{object}").errors[property]
    bs_control id, text, options do
      tag "input", class: "form-control input-sm", id: id, name: name, type: "text", value: value
    end
  end

  def bs_text_area(object, property, text, value, options = {})
    id = object.to_s + "_" + property.to_s
    name = object.to_s + "[" + property.to_s + "]"
    options[:errors] = self.instance_variable_get("@#{object}").errors[property]
    bs_control id, text, options do
      content_tag :textarea, class: "form-control input-sm", id: id, name: name, rows: 3 do
        value
      end
    end
  end

  def bs_select(object, property, text, collection, value, options = {})
    id = object.to_s + "_" + property.to_s
    name = object.to_s + "[" + property.to_s + "]"
    collection_key = options[:key] || :id
    collection_value = options[:value] || :value_text
    options[:errors] = self.instance_variable_get("@#{object}").errors[property]
    bs_control id, text, options do
      content_tag :select, class: "form-control input-sm", id: id, name: name do
        concat_content_tag :option, value: "" do
        end
        collection.each do |item|
          tag_options = { value: item.send(collection_key) }
          tag_options[:selected] = "selected" if item == value
          concat_content_tag :option, tag_options do
            item.send(collection_value) 
          end
        end
      end
    end
  end

  def bs_grouped_select(object, property, text, collection, value, options = {})
    id = object.to_s + "_" + property.to_s
    name = object.to_s + "[" + property.to_s + "]"
    collection_key = options[:key] || :id
    collection_value = options[:value] || :value_text
    collection_group_method = options[:group] || :group
    collection_group_label = options[:label] || :label
    options[:errors] = self.instance_variable_get("@#{object}").errors[property]
    bs_control id, text, options do
      content_tag :select, class: "form-control input-sm", id: id, name: name do
        concat (content_tag :option, value: "" do
        end)
        collection.each do |item|
          label = item.send(collection_group_label)
          group = item.send(collection_group_method)
          html = content_tag :optgroup, label: label do
            group.each do |elem|
              tag_options = { value: elem.send(collection_key) }
              tag_options[:selected] = "selected" if elem == value
              concat (content_tag :option, tag_options do
                elem.send(collection_value) 
              end)
            end
          end
          concat html
        end
      end
    end
  end

  private

  def concat_content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
    concat content_tag(name, content_or_options_with_block, options, escape, &block)
  end

  def bs_control(id, text, options)
    errors = options[:errors] || []

    classes = ["form-group"]
    classes << "required" if options[:required] || false
    classes << "has-error" if errors.any?

    content_tag :div, class: classes.join(" ") do
      concat_content_tag :label, class: "col-sm-2 control-label input-sm", for: id do
        text
      end
      concat_content_tag :div, class: "col-sm-5" do
        yield
      end
      if errors.any? then
        concat_content_tag :div, class: "col-sm-5" do
          errors.each do |message|
            concat_content_tag :p, class: "help-block" do
              content_tag :small do
                message
              end
            end
          end
        end
      end
    end
  end

  def doc_attribute_name(attribute, id)
    "document[attributes][#{id}]"
  end

  def doc_attribute_placeholder_for(property)
    case property
    when :value_text then 'Mingi tekst'
    when :value_number then 12345
    when :value_date then 'PP.KK.AAAA'
    end
  end

  def doc_attribute_label(attribute, name)
    label_tag name, class: "col-sm-2 control-label input-sm" do
      "#{attribute.doc_attribute_type.type_name.capitalize}"
    end
  end

  def doc_attribute_text(attribute, id, property)
    doc_attribute_control attribute, id do |name|
      value = attribute[property]
      placeholder = doc_attribute_placeholder_for property
      concat text_field_tag(name, value, class: "form-control input-sm", placeholder: placeholder)
    end
  end

  def doc_attribute_select(attribute, id, property)
    html_options = {include_blank: true, class: "form-control input-sm"}
    doc_attribute_control attribute, id do |name|
      collection = attribute.doc_attribute_type.atr_type_selection_values
      options = options_from_collection_for_select(collection, :atr_type_selection_value, :value_text, attribute[property])
      select_tag name, options, html_options
    end
  end

  def doc_attribute_control(attribute, id)
    content_tag :div, class: (attribute.required == 'Y' ? "form-group required" : "form-group") do
      name = doc_attribute_name attribute, id
      label_html = doc_attribute_label attribute, name
      control_html = content_tag :div, class: "col-sm-5" do
        yield name
      end
      concat label_html
      concat control_html
    end
  end
end
