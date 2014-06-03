# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    settings = {
        view: {
            dblClickExpand: (treeId, treeNode) ->
                treeNode.level > 0
        }
    }

    nodes = [{
        id:1, pId:0, name:"DOKUMENDID", open:true,
        children: [{ name: "test1", open: true, children: [{ name: "test1_1" }, { name: "test1_2" }]},
                   { name: "test2", open: true, children: [{ name: "test2_1" }, { name: "test2_2" }]}]
    }]

    $.fn.zTree.init($('#treeDemo'), settings, nodes)

$(document).ready(ready)
$(document).on('page:load', ready)
