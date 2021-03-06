3-1-03 `item.read()`
====================


    tudor.add [
      "3-1-03 `item.read()`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "(Directly create an Item instance)"
      (oo3d) -> [(new Item oo3d, 0)]




      "The method is a function and returns expected types"


      "`item.read()` is a function"
      ªF
      (item) -> item.read

      "`item.read()` returns an object"
      ªO
      (item) -> item.read()

      "`item.read('object')` returns an object"
      ªO
      (item) -> item.read 'object'

      "`item.read('log')` returns a string"
      ªS
      (item) -> item.read 'log'

      "`item.read('nwang')` returns a string"
      ªS
      (item) -> item.read 'nwang'




      "`item.read()` exceptions"
      tudor.throw


      "`format` must not be boolean"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:read()
        Optional `format` is boolean not string|object"""
      (item) -> item.read(false)


      "`format` must not be null"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:read()
        Optional `format` is null not string|object"""
      (item) -> item.read(null)


      "`format` 'NOPE!' is not recognized"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:read()
        Optional `format` is not 'object|log|nwang'"""
      (item) -> item.read('NOPE!')




      "`item.read()` usage"
      tudor.equal


      "Object from a default Item contains expected keys and values"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"
      (item) ->
        obj = item.read()
        "i #{obj.index}
         mT #{obj.mT[0] } #{obj.mT[1] } #{obj.mT[2] } #{obj.mT[3] }
            #{obj.mT[4] } #{obj.mT[5] } #{obj.mT[6] } #{obj.mT[7] }
            #{obj.mT[8] } #{obj.mT[9] } #{obj.mT[10]} #{obj.mT[11]}
            #{obj.mT[12]} #{obj.mT[13]} #{obj.mT[14]} #{obj.mT[15]}
         r #{obj.rX} #{obj.rY} #{obj.rZ}
         s #{obj.sX} #{obj.sY} #{obj.sZ}
         t #{obj.tX} #{obj.tY} #{obj.tZ}"

      "Object from a default Item contain only the expected keys"
      "index mT rX rY rZ sX sY sZ tX tY tZ"
      (item) ->
        obj = item.read()
        (k for k,v of obj).sort().join ' '

      "Dumped 'log' from a default Item as expected"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"
      (item) -> item.read 'log'

      "Dumped 'nwang' from a default Item as expected"
      "셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼죨죨죨셼셼셼"
      (item) -> item.read 'nwang'


Transform the item. 

      (item) ->
        item.edit
          rX: 0.001, rY: (Math.PI * -2 / 2306) + 0.0001, rZ: (Math.PI / 6) + (Math.PI * 10)
          sX: 0.001, sY: -0.5000001, sZ: 12
          tX: 0.001, tY: -0.5000001, tZ: 12
        [item]


      "Dumped 'log' from a transformed Item as expected"
      "
      i 0 mT 0.0008660224266350269 0.0004999974626116455 0.0000027730632154998602 
      0 0.24999919533729553 -0.4330132305622101 0.00022316427202895284 
      0 -0.03149650618433952 -0.011999956332147121 11.99995231628418 0 
      0.0010000000474974513 -0.5000001192092896 12 1 
      r 0.001 -0.0026247117550648683 31.93952531149623 
      s 0.001 -0.5000001 12 
      t 0.001 -0.5000001 12
      "
      (item) -> item.read 'log'

      "Dumped 'nwang' from a transformed Item as expected"
      '셼솅솁셼셼엺뱇셾셼쁁섄첀셼솆밄첀죨솆셢쵇솆밄첀솆밄첀'
      (item) -> item.read 'nwang'




    ];







