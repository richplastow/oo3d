04 Item.Mesh Constructor
=======================


    tudor.add [
      "04 Item.Mesh Constructor"
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
      -> Item.Mesh

      "`new` returns an object"
      ªO
      (oo3d) -> new Item.Mesh oo3d, 0




      "Item Constructor exceptions"
      tudor.throw


      "`config.main` must be an object"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `main` is number not object"""
      (oo3d) -> new Item.Mesh 123


      "`config.main` must be an Oo3d instance"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Item.Mesh {}


      "`index` must be a number"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is boolean not number"""
      (oo3d) -> new Item.Mesh oo3d, true


      "`index` must be an integer"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Mesh oo3d, 3.5


      "`index` must be positive"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Mesh oo3d, -44


      "`index` must be below 2^53"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Mesh oo3d, 9007199254740992


      "`config` must be an object"
      """
      /src/item/base-item.litcoffee:Item:constructor()
        Optional `config` is date not object"""
      (oo3d) -> new Item.Mesh oo3d, 0, new Date




      "Item.Mesh Constructor exceptions"


      "If set, config.positionI must refer to an actual positionBuffer"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        `config.positionI` foo does not exist""" # note, will not repeat 'foo'
      (oo3d) -> new Item.Mesh oo3d, 0, 
        positionI: 'foo'


      "If set, config.colorI must refer to an actual colorBuffer"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        `config.colorI` 123 does not exist"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        colorI: 123

Add a positionBuffer. 

      (oo3d) ->
        oo3d.addPositionBuffer [1,2,3]
        oo3d.addColorBuffer    [1,0,0,1, 0,1,0,1]
        [oo3d]


      "A positionBuffer with one coordinate does not match a colorBuffer with two"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        `config.positionI` mismatches config.colorI"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        positionI: 1
        colorI:    1


      "If set, config.renderMode must be a recognised value"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        `config.renderMode` ZERO is not recognised by WebGL"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        renderMode: 'ZERO'


      "If set, config.blend must be an array"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        If set, `config.blend` must be array not number"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        blend: 1


      "config.blend[0] (for item.sBlend) must be a recognised value"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        `config.blend[0]` is not recognised by WebGL"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        blend: ['TRIANGLES']


      "config.blend[1] (for item.dBlend) must be a recognised value"
      """
      /src/item/class-item-mesh.litcoffee:Item.Mesh:constructor()
        `config.blend[1]` is not recognised by WebGL"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        blend: ['ZERO'] # config.blend[1] is undefined in this case




      "Item Constructor usage"
      tudor.equal


      "`config` can be an empty object"
      '[object Item.Mesh]'
      (oo3d) ->
        mesh = new Item.Mesh oo3d, 0, {}
        ''+mesh


      "`item.mT` as expected"
      '1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1'
      (oo3d) ->
        mesh = new Item.Mesh oo3d, 0, {}
        ('' + n for n in mesh.mT).join ' '


      "`mesh.rX` `mesh.rY` `mesh.rZ` as expected"
      '0 0 0'
      (oo3d) ->
        mesh = new Item.Mesh oo3d, 0, {}
        [mesh.rX, mesh.rY, mesh.rZ].join ' '


      "`mesh.sX` `mesh.sY` `mesh.sZ` as expected"
      '1 1 1'
      (oo3d) ->
        mesh = new Item.Mesh oo3d, 0, {}
        [mesh.sX, mesh.sY, mesh.sZ].join ' '


      "`mesh.tX` `mesh.tY` `mesh.tZ` as expected"
      '0 0 0'
      (oo3d) ->
        mesh = new Item.Mesh oo3d, 0, {}
        [mesh.tX, mesh.tY, mesh.tZ].join ' '




      "Item.Mesh Constructor usage"


      "Complete set of `config` defaults"
      'TRIANGLESnullnull'
      (oo3d) ->
        mesh = new Item.Mesh oo3d, 0,
          positionI:  0
          colorI:     0
          renderMode: null # falsey, so defaults to 'TRIANGLES'
          blend:      null # falsey, so blending will be switched off
        mesh.renderMode + (ªtype mesh.sBlend) + (ªtype mesh.dBlend)



    ]












