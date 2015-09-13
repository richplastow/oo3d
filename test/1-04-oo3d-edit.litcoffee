1-04 `oo3d.edit()`
==================


    tudor.add [
      "1-04 `oo3d.edit()`"
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


      "`oo3d.edit()` is a function"
      ªF
      (oo3d) -> oo3d.edit

      "`oo3d.edit(0)` returns an object"
      ªO
      (oo3d) -> oo3d.edit 0



    ];
