2-03 `item.read()`
==================


    tudor.add [
      "2-03 `item.read()`"
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


      "`item.read()` is a function"
      ªF
      (oo3d, item) -> item.read

      "`item.read()` returns an object"
      ªO
      (oo3d, item) -> item.read()

      "`item.read('object')` returns an object"
      ªO
      (oo3d, item) -> item.read 'object'

      "`item.read('log')` returns a string"
      ªS
      (oo3d, item) -> item.read 'log'

      "`item.read('nwang')` returns a string"
      ªS
      (oo3d, item) -> item.read 'nwang'




      "`item.read()` exceptions"
      tudor.throw


      "`format` must not be boolean"
      """
      /oo3d/src/item/base-item.litcoffee:Item[0]:read()
        Optional `format` is boolean not string|object"""
      (oo3d, item) -> item.read(false)


      "`format` must not be null"
      """
      /oo3d/src/item/base-item.litcoffee:Item[0]:read()
        Optional `format` is null not string|object"""
      (oo3d, item) -> item.read(null)


      "`format` 'NOPE!' is not recognized"
      """
      /oo3d/src/item/base-item.litcoffee:Item[0]:read()
        Optional `format` is not 'object|log|nwang'"""
      (oo3d, item) -> item.read('NOPE!')




      "`item.read()` usage"
      tudor.equal


      "Object from a default Item contains expected keys and values"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"
      (oo3d, item) ->
        obj = item.read()
        "i #{obj.index}
         mT #{obj.mT[0] } #{obj.mT[1] } #{obj.mT[2] } #{obj.mT[3] }
            #{obj.mT[4] } #{obj.mT[5] } #{obj.mT[6] } #{obj.mT[7] }
            #{obj.mT[8] } #{obj.mT[9] } #{obj.mT[10]} #{obj.mT[11]}
            #{obj.mT[12]} #{obj.mT[13]} #{obj.mT[14]} #{obj.mT[15]}
         r #{obj.rX} #{obj.rY} #{obj.rZ}
         s #{obj.sX} #{obj.sY} #{obj.sZ}
         t #{obj.tX} #{obj.tY} #{obj.tZ}"

      "Object from a default Item contains no unexpected keys"
      "index mT rX rY rZ sX sY sZ tX tY tZ"
      (oo3d, item) ->
        obj = item.read()
        (k for k,v of obj).sort().join ' '

      "Dumped 'log' from a default Item as expected"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"
      (oo3d, item) -> item.read 'log'

      "Dumped 'nwang' from a default Item as expected"
      "셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼죨죨죨셼셼셼"
      (oo3d, item) -> item.read 'nwang'


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
      (oo3d, item) -> item.read 'log'

      "Dumped 'nwang' from a transformed Item as expected"
      '셼솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'
      (oo3d, item) -> item.read 'nwang'




    ];







