1-01 `new Oo3d`
===============


Define a function which will mock an Oo3d instance. 

    mockOo3d = ->
      class CanvasMock
        width:  2
        height: 1
        toString: -> '[object HTMLCanvasElement]'
        getContext: ->
          createBuffer:            -> {}
          createProgram:           ->
          useProgram:              ->
          attachShader:            ->
          linkProgram:             ->
          createShader:            ->
          shaderSource:            ->
          compileShader:           ->
          getShaderParameter:      -> true # compile success
          getProgramParameter:     -> true # compile success
          getAttribLocation:       ->
          enableVertexAttribArray: ->
          getUniformLocation:      ->
          bindBuffer:              ->
          bufferData:              ->
          clearColor:              ->
          enable:                  ->
          depthFunc:               ->
          scissor:                 ->
          clear:                   ->
          TRIANGLES: 4
      oo3d = new Main
        $main: new CanvasMock
      itemI = oo3d.add 'Item.Mesh', # 4
        positionI:  oo3d.add 'Buffer.Position' # 2
        colorI:     oo3d.add 'Buffer.Color' # 3
        renderMode: null # falsey, so defaults to 'TRIANGLES'
        blend:      null # falsey, so blending will be switched off
      item = oo3d._all[itemI] # NOT recommended use of API, `_all` is private
      [oo3d, item, itemI]




    tudor.add [
      "1-01 `new Oo3d`"
      tudor.is




      "The class and instance are expected types"


      "The class is a function"
      ªF
      -> Main

      "`new` returns an object"
      ªO
      -> new Main

      tudor.equal

      "`oo3d.toString()` as expected"
      '[object Oo3d]'
      (oo3d) ->
        oo3d = new Main
        ''+oo3d

      "`oo3d.C` as expected"
      'Oo3d'
      (oo3d) ->
        oo3d = new Main
        oo3d.C




      "Config exceptions"
      tudor.throw


      "If set, `config` must be an object"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        Optional `config` is array not object"""
      -> new Main []


      "If set, `config.$main` must be an HTMLCanvasElement"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        Optional `config.$main` is number not HTMLCanvasElement"""
      -> new Main { $main:123 }


      "If set, `config.bkgnd` must be a Float32Array"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        Optional `config.bkgnd` is number not float32array"""
      -> new Main { bkgnd:456 }


      "`config.bkgnd` must contain four elements"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        If set `config.bkgnd` must contain four elements"""
      -> new Main { bkgnd: new Float32Array [1,1,1] }


      "`config.bkgnd[0]` must be 0 or greater"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[0]` (red) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [-0.02,1,1,1] }


      "`config.bkgnd[0]` must be 1 or less"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[0]` (red) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [1.02,1,1,1] }


      "`config.bkgnd[1]` must be 0 or greater"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[1]` (green) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,-0.02,1,1] }


      "`config.bkgnd[1]` must be 1 or less"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[1]` (green) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1.02,1,1] }


      "`config.bkgnd[2]` must be 0 or greater"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[2]` (blue) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,-Infinity,1] }


      "`config.bkgnd[2]` must be 1 or less"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[2]` (blue) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,Infinity,1] }


      "`config.bkgnd[3]` must be 0 or greater"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[3]` (alpha) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,1,-0.000001] }


      "`config.bkgnd[3]` must be 1 or less"
      """
      /oo3d/src/class-main.litcoffee Oo3d()
        `config.bkgnd[3]` (alpha) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,0,1.00001] }




      "Config usage"
      tudor.equal


      "`config.bkgnd` can contain four floats 0-1, or NaN"
      '[object Oo3d]'
      -> ''+(new Main { bkgnd: new Float32Array [1,0,NaN,0.5] })



    ]
