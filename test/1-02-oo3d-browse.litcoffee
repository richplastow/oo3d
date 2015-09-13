1-02 `oo3d.browse()`
====================


    tudor.add [
      "1-02 `oo3d.browse()`"
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




      "The method is a function and returns an object"


      "`oo3d.browse()` is a function"
      ªF
      (oo3d) -> oo3d.browse

      "`oo3d.browse()` returns an array"
      ªA
      (oo3d) -> oo3d.browse()

      "`oo3d.browse('abc')` returns an array"
      ªA
      (oo3d) -> oo3d.browse 'abc'



    ];
