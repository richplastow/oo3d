3-1-01 `new Item`
=================


    tudor.add [
      "3-1-01 `new Item`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "The class and instance are expected types"


      "The class is a function"
      ªF
      -> Item

      "`new` returns an object"
      ªO
      (oo3d) -> new Item oo3d, 0 # `main`, `index`

      tudor.equal

      "`item.toString()` as expected"
      '[object Item]'
      (oo3d) ->
        item = new Item oo3d, 0
        ''+item

      "`item.C` as expected"
      'Item'
      (oo3d) ->
        item = new Item oo3d, 0
        item.C




      "Constructor exceptions"
      tudor.throw


      "`config.main` must be an object"
      """
      /oo3d/src/item/base-item.litcoffee Item#NaN()
        `main` is number not object"""
      (oo3d) -> new Item 123


      "`config.main` must be an Oo3d instance"
      """
      /oo3d/src/item/base-item.litcoffee Item#NaN()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Item {}


      "`index` must be a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#1()
        `index` is boolean not number"""
      (oo3d) -> new Item oo3d, true


      "`index` must be an integer"
      """
      /oo3d/src/item/base-item.litcoffee Item#3.5()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item oo3d, 3.5


      "`index` must be positive"
      """
      /oo3d/src/item/base-item.litcoffee Item#-44()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item oo3d, -44


      "`index` must be below 2^53"
      """
      /oo3d/src/item/base-item.litcoffee Item#9007199254740992()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item oo3d, 9007199254740992


      "`config` must be an object"
      """
      /oo3d/src/item/base-item.litcoffee Item#0()
        Optional `config` is date not object"""
      (oo3d) -> new Item oo3d, 0, new Date




      "Constructor usage"
      tudor.equal


      "`config` can be an empty object"
      '[object Item]'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        ''+item


      "`item.mT` as expected"
      '1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        ('' + n for n in item.mT).join ' '


      "`item.rX` `item.rY` `item.rZ` as expected"
      '0 0 0'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        [item.rX, item.rY, item.rZ].join ' '


      "`item.sX` `item.sY` `item.sZ` as expected"
      '1 1 1'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        [item.sX, item.sY, item.sZ].join ' '


      "`item.tX` `item.tY` `item.tZ` as expected"
      '0 0 0'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        [item.tX, item.tY, item.tZ].join ' '



    ]












