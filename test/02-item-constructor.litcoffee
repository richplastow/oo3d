02 Item Constructor
===================


    tudor.add [
      "02 Item Constructor"
      tudor.is




      "(Mock an `Oo3d` instance)"
      ->
        class CanvasMock
          width:  2
          height: 1
          toString: -> '[object HTMLCanvasElement]'
          getContext: ->
            createBuffer: -> {}
            bindBuffer:   ->
            bufferData:   ->
            clearColor:   ->
            enable:       ->
            depthFunc:    ->
            scissor:      ->
            clear:        ->
            TRIANGLES:    4
        oo3d = new Main
          $main: new CanvasMock
        [oo3d]




      "The class and instance are expected types"



      "The class is a function"
      ªF
      -> Item

      "`new` returns an object"
      ªO
      (oo3d) -> new Item oo3d, 0 # `main`, `index`




      "Constructor exceptions"
      tudor.throw


      "`config.main` must be an object"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `main` is number not object"""
      (oo3d) -> new Item 123


      "`config.main` must be an Oo3d instance"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Item {}


      "`index` must be a number"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is boolean not number"""
      (oo3d) -> new Item oo3d, true


      "`index` must be an integer"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item oo3d, 3.5


      "`index` must be positive"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item oo3d, -44


      "`index` must be below 2^53"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item oo3d, 9007199254740992


      "`config` must be an object"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        Optional `config` is date not object"""
      (oo3d) -> new Item oo3d, 0, new Date




      "Constructor usage"
      tudor.equal


      "`config` can be an empty object"
      '[object Item]'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        ''+item


      "`item.matTransform` as expected"
      '1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1'
      (oo3d) ->
        item = new Item oo3d, 0, {}
        ('' + n for n in item.matTransform).join ' '


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












