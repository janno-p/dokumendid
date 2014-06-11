existing = $ "div#clipboard"

if existing.length == 0
    existing = $("<div>").attr("id", "clipboard").addClass("modal fade")
    close_button = $("<button>").addClass("close").attr("type", "button").attr("data-dismiss", "modal").attr("aria-hidden", "true").append("&times;")
    title = $("<h4>").addClass("modal-title").append("Failide puhver")
    header = $("<div>").addClass("modal-header").append([close_button, title])
    body = $("<div>").addClass("modal-body")
    empty_button = $("<button>").addClass("btn btn-warning").attr("type", "button").append("Tühjenda puhver")
    empty_button.click ->
        $.ajax({ url: "/clipboard/clear", dataType: "script", complete: () ->
            $("table.files tr").removeClass("success")
            $("table.files input").attr("checked", false)
            $(".btn-buffer").addClass("disabled")
            $("[data-toggle='dropdown']").parent().removeClass("open")
            existing.find(".modal-body").empty()
            existing.modal("hide") })
        false
    save_button = $("<button>").addClass("btn btn-primary").attr("type", "button").append("Liiguta kataloogi")
    footer = $("<div>").addClass("modal-footer").append([empty_button, save_button])
    content = $("<div>").addClass("modal-content").append([header, body, footer])
    dialog = $("<div>").addClass("modal-dialog").append(content)
    existing.append(dialog).appendTo("body")

list = $("<ul>").addClass("list-group")

<% @documents.each do |doc| %>
cb = $("<a>").addClass("pull-right").attr("href", "#").attr("title", "Eemalda puhvrist").append($("<i>").addClass("fa fa-times"))
cb.click ->
    item = $(this).parent().parent()
    item.slideUp "fast", () ->
        item.remove()
        ch = $("input[data-id=<%= doc.document %>]")
        ch.attr("checked", false)
        ch.parent().parent().removeClass("success")
        $.ajax({ url: "/clipboard/remove/<%= doc.document %>", dataType: "script", complete: () ->
            if existing.find("li").length == 0
                $(".btn-buffer").addClass("disabled")
                $("[data-toggle='dropdown']").parent().removeClass("open")
                existing.modal("hide") })
    false
elem = $("<li>").addClass("list-group-item")
elem.append($("<p>").addClass("list-group-item-text").append([cb, $("<i>").addClass("fa fa-file-o"), " <%= doc.full_path %>"]))
list.append(elem)
<% end %>

body = existing.find(".modal-body")
body.empty()
body.append(list)

existing.modal()
