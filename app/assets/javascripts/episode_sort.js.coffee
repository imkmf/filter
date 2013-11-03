jQuery ->

  $('#sortable').sortable(
    axis: 'y'
    items: '.episode'

    stop: (e, ui) ->
      ui.item.effect("highlight", { color: "#C2C2C2" }, 1000)
    update: (e, ui) ->
      item_id = ui.item.data('item_id')
      position = ui.item.index()
      $.ajax(
        type: 'POST'
        url: "/episodes/sort"
        dataType: 'json'

        # the :thing hash gets passed to @thing.attributes
        # row_order is the default column name expected in ranked-model
        data: { id: item_id, episode: { row_order_position: position } }
      )
  )
