1-03 `oo3d.read()`
==================


    tudor.add [
      "1-03 `oo3d.read()`"
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


      "`oo3d.read()` is a function"
      ªF
      (oo3d) -> oo3d.read

      "`oo3d.read()` returns an object"
      ªO
      (oo3d) -> oo3d.read()

      "`oo3d.read('abc')` returns an object"
      ªO
      (oo3d) -> oo3d.read 'abc'



    ];
