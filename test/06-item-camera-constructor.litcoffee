06 Item.Camera Constructor
==========================


    tudor.add [
      "06 Item.Camera Constructor"
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
      -> Item.Camera

      "`new` returns an object"
      ªO
      (oo3d) -> new Item.Camera oo3d, 0




      "Item Constructor exceptions"
      tudor.throw


      "`config.main` must be an object"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        `main` is number not object"""
      (oo3d) -> new Item.Camera 123


      "`config.main` must be an Oo3d instance"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Item.Camera {}


      "`index` must be a number"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        `index` is boolean not number"""
      (oo3d) -> new Item.Camera oo3d, true


      "`index` must be an integer"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Camera oo3d, 3.5


      "`index` must be positive"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Camera oo3d, -44


      "`index` must be below 2^53"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Camera oo3d, 9007199254740992


      "`config` must be an object"
      """
      /oo3d/src/item/base-item.litcoffee:Item:constructor()
        Optional `config` is date not object"""
      (oo3d) -> new Item.Camera oo3d, 0, new Date




      "Item.Camera Constructor exceptions"


      "If set, config.fovy must be a number"
      """
      /src/item/class-item-camera.litcoffee:Item.Camera:constructor()
        Optional `config.fovy` is string not number"""
      (oo3d) -> new Item.Camera oo3d, 0, 
        fovy: 'abc'


      "If set, config.fovy must be greater than zero"
      """
      /src/item/class-item-camera.litcoffee:Item.Camera:constructor()
        Optional `config.fovy` is 0 not greater than zero"""
      (oo3d) -> new Item.Camera oo3d, 0, 
        fovy: 0


      "If set, config.aspect must be a number"
      """
      /src/item/class-item-camera.litcoffee:Item.Camera:constructor()
        Optional `config.aspect` is array not number"""
      (oo3d) -> new Item.Camera oo3d, 0, 
        aspect: []


      "If set, config.aspect must be greater than zero"
      """
      /src/item/class-item-camera.litcoffee:Item.Camera:constructor()
        Optional `config.aspect` is -3 not greater than zero"""
      (oo3d) -> new Item.Camera oo3d, 0, 
        aspect: -3




      "Item Constructor usage"
      tudor.equal


      "`config` can be an empty object"
      '[object Item.Camera]'
      (oo3d) ->
        camera = new Item.Camera oo3d, 0, {}
        ''+camera


      "`item.mT` as expected"
      '1 0 0 0 0 1 0 0 0 0 1 0 0 0 -4 1'
      (oo3d) ->
        camera = new Item.Camera oo3d, 0, {}
        ('' + n for n in camera.mT).join ' '


      "`camera.rX` `camera.rY` `camera.rZ` as expected"
      '0 0 0'
      (oo3d) ->
        camera = new Item.Camera oo3d, 0, {}
        [camera.rX, camera.rY, camera.rZ].join ' '


      "`camera.sX` `camera.sY` `camera.sZ` as expected"
      '1 1 1'
      (oo3d) ->
        camera = new Item.Camera oo3d, 0, {}
        [camera.sX, camera.sY, camera.sZ].join ' '


      "`camera.tX` `camera.tY` `camera.tZ` as expected"
      '0 0 -4'
      (oo3d) ->
        camera = new Item.Camera oo3d, 0, {}
        [camera.tX, camera.tY, camera.tZ].join ' '




      "Item.Camera Constructor usage"


      "Complete set of `config` defaults"
      '0.785398163 2'
      (oo3d) ->
        camera = new Item.Camera oo3d, 0
        camera.fovy + ' ' + camera.aspect



    ]












