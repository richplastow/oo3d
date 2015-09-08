03 `item.dump()`
===========================


    tudor.add [
      "03 `item.dump()`"
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




      "The method is a function and returns expected types"


      "`item.dump()` is a function"
      ªF
      (oo3d, item) -> item.dump

      "`item.dump()` returns an object"
      ªO
      (oo3d, item) -> item.dump()

      "`item.dump('object')` returns an object"
      ªO
      (oo3d, item) -> item.dump 'object'

      "`item.dump('log')` returns a string"
      ªS
      (oo3d, item) -> item.dump 'log'

      "`item.dump('nwang')` returns a string"
      ªS
      (oo3d, item) -> item.dump 'nwang'


      "`item.dump('i 0 mT 1 0 0 0 ... t 0 0 0')` returns an object"
      ªO
      (oo3d, item) -> item.dump "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"


      "`item.rX` is a number"
      ªN
      (oo3d, item) -> item.rX

      "`item.rY` is a number"
      ªN
      (oo3d, item) -> item.rY

      "`item.rZ` is a number"
      ªN
      (oo3d, item) -> item.rZ

      "`item.sX` is a number"
      ªN
      (oo3d, item) -> item.sX

      "`item.sY` is a number"
      ªN
      (oo3d, item) -> item.sY

      "`item.sZ` is a number"
      ªN
      (oo3d, item) -> item.sZ

      "`item.tX` is a number"
      ªN
      (oo3d, item) -> item.tX

      "`item.tY` is a number"
      ªN
      (oo3d, item) -> item.tY

      "`item.tZ` is a number"
      ªN
      (oo3d, item) -> item.tZ




      "`item.dump()` exceptions"
      tudor.throw


      "`format` must not be boolean"
      """
      /src/item/base-item.litcoffee:Item:dump()
        Optional `formatOrState` is boolean not string|object"""
      (oo3d, item) -> item.dump(false)


      "`format` must not be null"
      """
      /src/item/base-item.litcoffee:Item:dump()
        Optional `formatOrState` is null not string|object"""
      (oo3d, item) -> item.dump(null)


      "`format` 'NOPE!' is not recognized"
      """
      /src/item/base-item.litcoffee:Item:dump()
        Optional `formatOrState` is not a valid string or object"""
      (oo3d, item) -> item.dump('NOPE!')




      "`item.dump()` as a state-getter"
      tudor.equal


      "JSON from a default Item as expected"
      "{index:0,mT:{0:1,1:0,2:0,3:0,4:0,5:1,6:0,7:0,8:0,9:0,10:1,11:0,12:0,13:0,14:0,15:1},rX:0,rY:0,rZ:0,sX:1,sY:1,sZ:1,tX:0,tY:0,tZ:0}"
      (oo3d, item) -> (JSON.stringify item.dump()).replace(/"/g, '')

      "Dumped 'log' from a default Item as expected"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"
      (oo3d, item) -> item.dump 'log'

      "Dumped 'nwang' from a default Item as expected"
      "셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼죨죨죨셼셼셼"
      (oo3d, item) -> item.dump 'nwang'


Transform the item. 

      (oo3d, item) ->
        oo3d.rotate     0.001, (Math.PI * -2 / 2306) + 0.0001, (Math.PI / 6) + (Math.PI * 10), 0 # x, y, z, targetIndex
        oo3d.scale      0.001, -0.5000001, 12, 0 # x, y, z, targetIndex
        oo3d.translate  0.001, -0.5000001, 12, 0 # x, y, z, targetIndex
        [oo3d, item]


      "Dumped 'log' from a transformed Item as expected"
      "
      i 0 mT 0.0008660224266350269 0.0004999975208193064 0.0000027730632154998602 
      0 0.24999918043613434 -0.4330132305622101 0.0002231643011327833 0 
      -0.031496502459049225 -0.011999955400824547 11.99995231628418 0 
      -0.5029568076133728 0.07250769436359406 143.9993133544922 1 
      r 0.001 -0.0026247117550648683 31.93952531149623 
      s 0.001 -0.5000001 12 
      t 0.001 -0.5000001 12
      "
      (oo3d, item) -> item.dump 'log'

      "Dumped 'nwang' from a transformed Item as expected"
      '셼솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'
      (oo3d, item) -> item.dump 'nwang'




      "`item.dump()` as a state-setter"
      tudor.equal


      "Use a 'log' to reset a transformed Item"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.dump 'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
        item.dump 'log'


      "Note that a 'log' does not have to be internally consistent"
      'i 0 mT 1 2 3 4 5 6 7 8 9 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.dump 'i 0 mT 1 2 3 4 5 6 7 8 9 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
        item.dump 'log'


      "Use an 'nwang' to transform an Item"
      "
      i 0 mT 0.0008999999845400453 0.0005000000237487257 0 
      0 0.25 -0.43299999833106995 0.00019999999494757503 0 
      -0.03150000050663948 -0.012000000104308128 12 0 
      -0.503000020980835 0.07249999791383743 144 1 
      r 0.001 -0.0026 31.9 
      s 0.001 -0.5 12 
      t 0.001 -0.5 12
      "
      (oo3d, item) ->
        item.dump '셼솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'
        item.dump 'log'




    ]












