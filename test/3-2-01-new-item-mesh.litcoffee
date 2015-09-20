3-2-01 `new Item.Mesh`
======================


    tudor.add [
      "3-2-01 `new Item.Mesh`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




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
      /oo3d/src/item/base-item.litcoffee Item#NaN()
        `main` is number not object"""
      (oo3d) -> new Item.Mesh 123


      "`config.main` must be an Oo3d instance"
      """
      /oo3d/src/item/base-item.litcoffee Item#NaN()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Item.Mesh {}


      "`index` must be a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#1()
        `index` is boolean not number"""
      (oo3d) -> new Item.Mesh oo3d, true


      "`index` must be an integer"
      """
      /oo3d/src/item/base-item.litcoffee Item#3.5()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Mesh oo3d, 3.5


      "`index` must be positive"
      """
      /oo3d/src/item/base-item.litcoffee Item#-44()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Mesh oo3d, -44


      "`index` must be below 2^53"
      """
      /oo3d/src/item/base-item.litcoffee Item#9007199254740992()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Item.Mesh oo3d, 9007199254740992


      "`config` must be an object"
      """
      /oo3d/src/item/base-item.litcoffee Item#0()
        Optional `config` is date not object"""
      (oo3d) -> new Item.Mesh oo3d, 0, new Date




      "Item.Mesh Constructor exceptions"


      "If set, config.positionI must be a number"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        Optional `config.positionI` is string not number"""
      (oo3d) -> new Item.Mesh oo3d, 0,
        positionI: '22'

      "If set, config.positionI must be an integer"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.positionI` is 12.5 not 0 or a +ve int < 2^53"""
      (oo3d) -> new Item.Mesh oo3d, 0,
        positionI: 12.5

      "If set, config.positionI must refer to an instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.positionI` no such instance `main._all[123]`"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        positionI: 123

      "If set, config.positionI must refer to a Buffer.Position instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.positionI` refs Buffer.Color at `main._all[1]`"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        positionI: 1


      "If set, config.colorI must be a number"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        Optional `config.colorI` is array not number"""
      (oo3d) -> new Item.Mesh oo3d, 0,
        colorI: []

      "If set, config.colorI must be a positive number"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.colorI` is -1 not 0 or a +ve int < 2^53"""
      (oo3d) -> new Item.Mesh oo3d, 0,
        colorI: -1

      "If set, config.colorI must refer to an instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.colorI` no such instance `main._all[123]`"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        colorI: 123

      "If set, config.colorI must refer to a Buffer.Position instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.colorI` refs Buffer.Position at `main._all[0]`"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        colorI: 0


      "A Buffer.Position with one vertex does not match a Buffer.Color with two"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.positionI` mismatches config.colorI"""
      (oo3d) ->
        positionI = oo3d.add 'Buffer.Position', { data: [1,2,3]            }
        colorI    = oo3d.add 'Buffer.Color',    { data: [1,0,0,1, 0,1,0,1] }
        new Item.Mesh oo3d, 0, { positionI:positionI, colorI:colorI }


      "If set, config.renderMode must be a recognised value"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.renderMode` ZERO is not recognised by WebGL"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        renderMode: 'ZERO'


      "If set, config.blend must be an array"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        If set, `config.blend` must be array not number"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        blend: 1


      "config.blend[0] (for item.sBlend) must be a recognised value"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
        `config.blend[0]` is not recognised by WebGL"""
      (oo3d) -> new Item.Mesh oo3d, 0, 
        blend: ['TRIANGLES']


      "config.blend[1] (for item.dBlend) must be a recognised value"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0()
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
          colorI:     1
          renderMode: null # falsey, so defaults to 'TRIANGLES'
          blend:      null # falsey, so blending will be switched off
        mesh.renderMode + (ªtype mesh.sBlend) + (ªtype mesh.dBlend)



    ]












