4-1-01 `new Layer`
==================


    tudor.add [
      "4-1-01 `new Layer`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "The class and instance are expected types"


      "The class is a function"
      ªF
      -> Layer

      "`new` returns an object"
      ªO
      (oo3d) -> new Layer oo3d, 0 # `main`, `index`

      tudor.equal

      "`layer.toString()` as expected"
      '[object Layer]'
      (oo3d) ->
        layer = new Layer oo3d, 0
        ''+layer

      "`layer.C` as expected"
      'Layer'
      (oo3d) ->
        layer = new Layer oo3d, 0
        layer.C




      "layer Constructor exceptions"
      tudor.throw


      "`config.main` must be an object"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#NaN()
        `main` is number not object"""
      (oo3d) -> new Layer 123

      "`config.main` must be an Oo3d instance"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#NaN()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Layer {}

      "`index` must be a number"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#1()
        `index` is boolean not number"""
      (oo3d) -> new Layer oo3d, true

      "`index` must be an integer"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#3.5()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Layer oo3d, 3.5

      "`index` must be positive"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#-44()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Layer oo3d, -44

      "`index` must be below 2^53"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#9007199254740992()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Layer oo3d, 9007199254740992

      "`config` must be an object"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#0()
        Optional `config` is date not object"""
      (oo3d) -> new Layer oo3d, 0, new Date

      "`config.rendererIs` must be a regular array"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#0()
        `config.rendererIs` is uint8array not array"""
      (oo3d) -> new Layer oo3d, 0, { rendererIs:new Uint8Array() }


Add some instances to `oo3d._all`

      (oo3d) -> 
        oo3d.add 'Item.Mesh' # 5
        oo3d.add 'Renderer.Wireframe', # 8
          programI: oo3d.add 'Item.Camera' # 6
          cameraI:  oo3d.add 'Program.Flat' # 7
        [oo3d]


      "`config.rendererIs` must only contain numbers"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#0()
        `config.rendererIs[1]` is string not number"""
      (oo3d) -> new Layer oo3d, 0, { rendererIs:[8, 'foo', 8, 'bar'] }

      "`config.rendererIs` must all refer to Renderer instances"
      """
      /oo3d/src/layer/base-layer.litcoffee Layer#0()
        `config.rendererIs[0]` refs Item.Camera at `main._all[6]`"""
      (oo3d) -> new Layer oo3d, 0, { rendererIs:[6, 7, 'foobar'] }






      "layer Constructor usage"
      tudor.equal


      "Complete set of `config` defaults"
      ªA
      (oo3d) ->
        layer = new Layer oo3d, 0, { rendererIs:[8,8] }
        ªtype layer.renderers



    ]












