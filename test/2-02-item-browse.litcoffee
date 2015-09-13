2-02 `item.browse()`
====================


    tudor.add [
      "2-02 `item.browse()`"
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
        itemI = oo3d.addMesh
          positionI:  0
          colorI:     0
          renderMode: null # falsey, so defaults to 'TRIANGLES'
          blend:      null # falsey, so blending will be switched off
        item = oo3d.meshes[itemI] # not a recommended use of API!
        [oo3d, item]




      "The method is a function and returns an object"


      "`item.browse()` is a function"
      ªF
      (oo3d, item) -> item.browse

      "`item.browse()` returns an array"
      ªA
      (oo3d, item) -> item.browse()


      "`item.browse('abc')` returns an array"
      ªA
      (oo3d, item) -> item.browse 'abc'



    ];
