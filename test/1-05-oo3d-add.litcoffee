1-05 `oo3d.add()`
=================


    tudor.add [
      "1-05 `oo3d.add()`"
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




      "The method is a function and returns a number"


      "`oo3d.add()` is a function"
      ªF
      (oo3d) -> oo3d.add

      "`oo3d.add('Item.Mesh')` returns a number"
      ªN
      (oo3d) -> oo3d.add 'Item.Mesh'




      "`item.add()` exceptions"
      tudor.throw


      "`className` is not optional"
      """
      /oo3d/src/class-main.litcoffee:Main:add()
        `className` is undefined not string"""
      (oo3d) -> oo3d.add()

      "`className` must not be boolean"
      """
      /oo3d/src/class-main.litcoffee:Main:add()
        `className` is boolean not string"""
      (oo3d) -> oo3d.add true

      "`className` must not be an empty string"
      """
      /oo3d/src/class-main.litcoffee:Main:add()
        `className` must be in 2 parts, not 1"""
      (oo3d) -> oo3d.add ''

      "`className` must not have three parts"
      """
      /oo3d/src/class-main.litcoffee:Main:add()
        `className` must be in 2 parts, not 3"""
      (oo3d) -> oo3d.add 'Item.Mesh.FooBar'

      "`className` base must be a recognised base-class"
      """
      /oo3d/src/class-main.litcoffee:Main:add()
        `className` base must be 'Buffer|Item|Layer|Program|Renderer'"""
      (oo3d) -> oo3d.add 'NotReally.Anything'

      "`className` child must be a recognised child-class"
      """
      /oo3d/src/class-main.litcoffee:Main:add()
        For `className` 'Item' use 'Camera|Mesh'"""
      (oo3d) -> oo3d.add 'Item.NonExistant'



    ];
