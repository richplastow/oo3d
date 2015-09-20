3-2-03 `Item.Mesh:read()`
=========================


    tudor.add [
      "3-2-03 `Item.Mesh:read()`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "(Directly create an Item.Mesh instance)"
      (oo3d) -> [(new Item.Mesh oo3d, 0)]




      "The method is a function and returns expected types"


      "`mesh.read()` is a function"
      ªF
      (mesh) -> mesh.read

      "`mesh.read()` returns an object"
      ªO
      (mesh) -> mesh.read()

      "`mesh.read('object')` returns an object"
      ªO
      (mesh) -> mesh.read 'object'

      "`mesh.read('log')` returns a string"
      ªS
      (mesh) -> mesh.read 'log'

      "`mesh.read('nwang')` returns a string"
      ªS
      (mesh) -> mesh.read 'nwang'




      "`mesh.read()` exceptions"
      tudor.throw


      "`format` must not be boolean"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:read()
        Optional `format` is boolean not string|object"""
      (mesh) -> mesh.read(false)


      "`format` must not be null"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:read()
        Optional `format` is null not string|object"""
      (mesh) -> mesh.read(null)


      "`format` 'NOPE!' is not recognized"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:read()
        Optional `format` is not 'object|log|nwang'"""
      (mesh) -> mesh.read('NOPE!')




      "`mesh.read()` usage"
      tudor.equal


      "Object from a default Item.Mesh contains expected keys and values"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"
      (mesh) ->
        obj = mesh.read()
        "i #{obj.index}
         mT #{obj.mT[0] } #{obj.mT[1] } #{obj.mT[2] } #{obj.mT[3] }
            #{obj.mT[4] } #{obj.mT[5] } #{obj.mT[6] } #{obj.mT[7] }
            #{obj.mT[8] } #{obj.mT[9] } #{obj.mT[10]} #{obj.mT[11]}
            #{obj.mT[12]} #{obj.mT[13]} #{obj.mT[14]} #{obj.mT[15]}
         r #{obj.rX} #{obj.rY} #{obj.rZ}
         s #{obj.sX} #{obj.sY} #{obj.sZ}
         t #{obj.tX} #{obj.tY} #{obj.tZ}"

      "Object from a default Item.Mesh contain only the expected keys"
      "bC bP index mT rX rY rZ sX sY sZ tX tY tZ"
      (mesh) ->
        obj = mesh.read()
        (k for k,v of obj).sort().join ' '

      "Dumped 'log' from a default Item.Mesh as expected"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1"
      (mesh) -> mesh.read 'log'

      "Dumped 'nwang' from a default Item.Mesh as expected"
      "셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼죨죨죨셼셼셼셼죨"
      (mesh) -> mesh.read 'nwang'


Transform the mesh. 

      (mesh) ->
        mesh.edit
          rX: 0.001, rY: (Math.PI * -2 / 2306) + 0.0001, rZ: (Math.PI / 6) + (Math.PI * 10)
          sX: 0.001, sY: -0.5000001, sZ: 12
          tX: 0.001, tY: -0.5000001, tZ: 12
        [mesh]


      "Dumped 'log' from a transformed Item.Mesh as expected"
      "
      i 0 mT 0.0008660224266350269 0.0004999974626116455 0.0000027730632154998602 
      0 0.24999919533729553 -0.4330132305622101 0.00022316427202895284 
      0 -0.03149650618433952 -0.011999956332147121 11.99995231628418 0 
      0.0010000000474974513 -0.5000001192092896 12 1 
      r 0.001 -0.0026247117550648683 31.93952531149623 
      s 0.001 -0.5000001 12 
      t 0.001 -0.5000001 12
      bP 0 bC 1
      "
      (mesh) -> mesh.read 'log'

      "Dumped 'nwang' from a transformed Item.Mesh as expected"
      '셼솅솁셼셼엺뱇셾셼쁁섄첀셼솆밄첀죨솆셢쵇솆밄첀솆밄첀셼죨'
      (mesh) -> mesh.read 'nwang'




    ];







