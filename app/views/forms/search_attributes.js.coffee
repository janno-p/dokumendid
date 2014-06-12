container = $ "div#attributes"
container.empty()

<% unless @attributes.any? %>
$("<div>").addClass("form-group")
          .append($("<label>").addClass("col-sm-3 control-label input-sm")
                              .attr("for", "document_attribute_value")
                              .append("Atribuudi väärtus"))
          .append($("<div>").addClass("col-sm-5")
                            .append($("<input>").addClass("form-control input-sm")
                                                .attr("id", "document_attribute_value")
                                                .attr("name", "document[attribute_value]")
                                                .attr("type", "text")))
          .appendTo(container)
<% end %>

<% @attributes.each do |attribute| %>
<% if attribute.doc_attribute_type.data_type_fk == 4 %>
options = []
<% attribute.doc_attribute_type.atr_type_selection_values.each do |selection_value| %>
options.push($("<option>").val("<%= selection_value.atr_type_selection_value %>")
                          .append("<%= selection_value.value_text %>"))
<% end %>
$("<div>").addClass("form-group")
          .append($("<label>").addClass("col-sm-3 control-label input-sm")
                              .attr("for", "document_attribute_<%= attribute.doc_type_attribute %>")
                              .append("<%= attribute.doc_attribute_type.type_name.capitalize %>"))
          .append($("<div>").addClass("col-sm-5")
                            .append($("<select>").addClass("form-control input-sm")
                                                 .attr("id", "document_attribute_<%= attribute.doc_type_attribute %>")
                                                 .attr("name", "document[attribute][<%= attribute.doc_type_attribute %>]")
                                                 .append($("<option>").val(""))
                                                 .append(options)))
          .appendTo(container)
<% else %>
$("<div>").addClass("form-group")
          .append($("<label>").addClass("col-sm-3 control-label input-sm")
                              .attr("for", "document_attribute_<%= attribute.doc_type_attribute %>")
                              .append("<%= attribute.doc_attribute_type.type_name.capitalize %>"))
          .append($("<div>").addClass("col-sm-5")
                            .append($("<input>").addClass("form-control input-sm")
                                                .attr("id", "document_attribute_<%= attribute.doc_type_attribute %>")
                                                .attr("name", "document[attribute][<%= attribute.doc_type_attribute %>]")
                                                .attr("type", "text")))
          .appendTo(container)
<% end %>
<% end %>
