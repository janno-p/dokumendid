module DocumentsHelper
  def document_attribute(attribute)
    case attribute.data_type_id
    when 1 then doc_attribute_text(attribute, :value_text)
    when 2 then doc_attribute_text(attribute, :value_number)
    when 3 then doc_attribute_text(attribute, :value_date)
    when 4 then doc_attribute_select(attribute, :atr_type_selection_value_fk)
    else raise "Unknown attribute type: #{attribute.data_type_id}"
    end
  end

  def bs_text_field(object, property, text, value, options = {})
    bs_control object, property, text, options do |id, name|
      tag "input", class: "form-control input-sm", id: id, name: name, type: "text", value: value
    end
  end

  def bs_text_area(object, property, text, value, options = {})
    bs_control object, property, text, options do |id, name|
      content_tag :textarea, class: "form-control input-sm", id: id, name: name, rows: 3 do
        value
      end
    end
  end

  def bs_select(object, property, text, collection, value, options = {})
    collection_key = options[:key] || :id
    collection_value = options[:value] || :value_text
    bs_control object, property, text, options do |id, name|
      content_tag :select, class: "form-control input-sm", id: id, name: name do
        concat (content_tag :option, value: "" do
        end)
        collection.each do |item|
          tag_options = { value: item.send(collection_key) }
          tag_options[:selected] = "selected" if item == value
          concat (content_tag :option, tag_options do
            item.send(collection_value) 
          end)
        end
      end
    end
  end

  def bs_grouped_select(object, property, text, collection, value, options = {})
    collection_key = options[:key] || :id
    collection_value = options[:value] || :value_text
    collection_group_method = options[:group] || :group
    collection_group_label = options[:label] || :label
    bs_control object, property, text, options do |id, name|
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

  def bs_control(object, property, text, options)
    id = object.to_s + "_" + property.to_s
    name = object.to_s + "[" + property.to_s + "]"
    required = options[:required] || false
    errors = self.instance_variable_get("@#{object}").errors[property]
    content_tag :div, class: "form-group" + (required ? " required" : "") + (errors.any? ? " has-error" : "") do
      concat (content_tag :label, class: "col-sm-2 control-label input-sm", for: id do
        text
      end)
      concat (content_tag :div, class: "col-sm-5" do
        yield id, name
      end)
      if errors.any? then
        html = content_tag :div, class: "col-sm-5" do
          errors.each do |message|
            html = content_tag :p, class: "help-block" do
              content_tag :small do
                message
              end
            end
            concat html
          end
        end
        concat html
      end
    end
  end

  def doc_attribute_name(attribute)
    "document[attributes][#{attribute.attribute_id}]"
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

  def doc_attribute_text(attribute, property)
    doc_attribute_control attribute do |name|
      value = attribute[property]
      placeholder = doc_attribute_placeholder_for property
      concat text_field_tag(name, value, class: "form-control input-sm", placeholder: placeholder)
    end
  end

  def doc_attribute_select(attribute, property)
    html_options = {include_blank: true, class: "form-control input-sm"}
    doc_attribute_control attribute do |name|
      collection = attribute.doc_attribute_type.atr_type_selection_values
      options = options_from_collection_for_select(collection, :atr_type_selection_value, :value_text, attribute[property])
      select_tag name, options, html_options
    end
  end

  def doc_attribute_control(attribute)
    content_tag :div, class: (attribute.required == 'Y' ? "form-group required" : "form-group") do
      name = doc_attribute_name attribute
      label_html = doc_attribute_label attribute, name
      control_html = content_tag :div, class: "col-sm-5" do
        yield name
      end
      concat label_html
      concat control_html
    end
  end
end
