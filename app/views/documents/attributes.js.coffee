existing = $ "div#attributes"

if existing.length == 0
  existing = $("<div>").attr("id", "attributes")
  $(".form-group:last").before(existing)

existing.empty()

<% if @doc_type.doc_type_attributes.any? %>
existing.append $($("<h4>").append($("<small>").append("Dokumendi atribuudid")))
<% @doc_type.doc_type_attributes.each do |attribute| %>
existing.append '<%= document_attribute attribute %>'
<% end %>
<% end %>
