02 Item Usage
=============


    tudor.add [
      "02 Item Usage"
      tudor.is




      "(Mock an `Oo3d` instance)"
      ->
        oo3d = new Main
        oo3d.gl =
          createBuffer: -> {}
          bindBuffer:   ->
          bufferData:   ->
          TRIANGLES:    4
        oo3d.initBuffers()
        [oo3d]




      "The class and instance are expected types"



      "The class is a function"
      ªF
      -> Item

      "`new` returns an object"
      ªO
      (oo3d) -> new Item oo3d, 0




      "Constructor exceptions"
      tudor.throw


      "`config` must not be a number"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config` must be object not number"
      (oo3d) -> new Item oo3d, 0, 123


      "`config.main` must be an object"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `main` must be object not number"
      (oo3d) -> new Item 123


      "`config.main` must be an Oo3d instance"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `main` must be [object Oo3d] not [object Object]"
      (oo3d) -> new Item {}


      "`index` must be a number"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `index` must be number not boolean"
      (oo3d) -> new Item oo3d, true


      "If set, config.positionI must refer to an actual positionBuffer"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config.positionI` foo does not exist" # note, will not repeat 'foo'
      (oo3d) -> new Item oo3d, 0, 
        positionI: 'foo'


      "If set, config.colorI must refer to an actual colorBuffer"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config.colorI` 123 does not exist"
      (oo3d) -> new Item oo3d, 0, 
        colorI: 123

Add a positionBuffer. 

      (oo3d) ->
        oo3d.addPositionBuffer [1,2,3]
        oo3d.addColorBuffer    [1,0,0,1, 0,1,0,1]
        [oo3d]


      "A positionBuffer with one coordinate does not match a colorBuffer with two"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config.positionI` mismatches config.colorI"
      (oo3d) -> new Item oo3d, 0, 
        positionI: 1
        colorI:    1


      "If set, config.renderMode must be a recognised value"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config.renderMode` ZERO is not recognised by WebGL"
      (oo3d) -> new Item oo3d, 0, 
        renderMode: 'ZERO'


      "If set, config.blend must be an array"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ If set, `config.blend` must be array not number"
      (oo3d) -> new Item oo3d, 0, 
        blend: 1


      "config.blend[0] (for item.sBlend) must be a recognised value"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config.blend[0]` is not recognised by WebGL"
      (oo3d) -> new Item oo3d, 0, 
        blend: ['TRIANGLES']


      "config.blend[1] (for item.dBlend) must be a recognised value"
      "/src/class-item.litcoffee:Item:constructor()\n
      \ `config.blend[1]` is not recognised by WebGL"
      (oo3d) -> new Item oo3d, 0, 
        blend: ['ZERO'] # config.blend[1] is undefined in this case




      "Constructor usage"
      tudor.equal


      "Complete set of `config` defaults"
      'TRIANGLESnullnull'
      (oo3d) ->
        item = new Item oo3d, 0,
          positionI:  0
          colorI:     0
          renderMode: null # falsey, so defaults to 'TRIANGLES'
          blend:      null # falsey, so blending will be switched off
        item.renderMode + (ªtype item.sBlend) + (ªtype item.dBlend)



    ]












