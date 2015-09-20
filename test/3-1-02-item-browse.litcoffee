3-1-02 `item.browse()`
======================


    tudor.add [
      "3-1-02 `item.browse()`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "The method is a function and returns an object"


      "`item.browse()` is a function"
      ªF
      (oo3d) ->
        item = new Item oo3d, 0
        item.browse

      "`item.browse()` returns an array"
      ªA
      (oo3d) ->
        item = new Item oo3d, 0
        item.browse()


      "`item.browse('abc')` returns an array"
      ªA
      (oo3d) ->
        item = new Item oo3d, 0
        item.browse 'abc'



    ];
