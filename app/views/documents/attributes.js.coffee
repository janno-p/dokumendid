existing = $ "div#attributes"

if existing.length == 0
    existing = $("<div>").attr("id", "attributes")
    $(".form-group:last").before(existing)

existing.empty()

<% if @doc_type.doc_type_attributes.any? %>
existing.append $($("<h4>").append($("<small>").append("Dokumendi atribuudid")))
    <% @doc_type.doc_type_attributes.each do |attribute|
        doc_attribute = DocAttribute.new(attribute.to_doc_attribute(nil)) %>
existing.append '<%= bs_doc_attribute doc_attribute, attribute.doc_type_attribute %>'
    <% end %>
<% end %>
