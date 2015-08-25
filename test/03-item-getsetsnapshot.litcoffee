03 Item `get/setSnapshot()`
===========================


    tudor.add [
      "03 Item `get/setSnapshot()`"
      tudor.is




      "(Mock an `Oo3d` and an 'Item' instance)"
      ->
        oo3d = new Main
        oo3d.gl =
          createBuffer: -> {}
          bindBuffer:   ->
          bufferData:   ->
          TRIANGLES:    4
        oo3d.initBuffers()
        itemI = oo3d.addItem
          positionI:  0
          colorI:     0
          renderMode: null # falsey, so defaults to 'TRIANGLES'
          blend:      null # falsey, so blending will be switched off
        item = oo3d.items[itemI] # not a recommended use of API!
        [oo3d, item]




      "The methods are expected types"



      "`getSnapshot()` is a function"
      ªF
      (oo3d, item) -> item.getSnapshot


      "`setSnapshot()` is a function"
      ªF
      (oo3d, item) -> item.setSnapshot




      "getSnapshot usage"
      tudor.equal


      "Snapshot object from a default Item as expected"
      "
      ,rX:0,rY:0,rZ:0,sX:1,sY:1,sZ:1,tX:0,tY:0,tZ:0}
      "
      (oo3d, item) -> (JSON.stringify item.getSnapshot()).replace(/"/g, '').slice -46


      "Snapshot log from a default Item as expected"
      "m:[1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1], rX:0, rY:0, rZ:0, sX:1, sY:1, sZ:1, tX:0, tY:0, tZ:0"
      (oo3d, item) -> item.getSnapshot 'log'


      "Snapshot URI from a default Item as expected"
      "AAAUUUAAA"
      (oo3d, item) -> item.getSnapshot 'uri'


      (oo3d, item) ->
        oo3d.rotate     0.001, (Math.PI * -2 / 2306) + 0.0001, (Math.PI / 6) + (Math.PI * 10), 0 # x, y, z, targetIndex
        oo3d.scale      0.001, -0.5000001, 1345, 0 # x, y, z, targetIndex
        oo3d.translate  0.001, -0.5000001, 1345, 0 # x, y, z, targetIndex
        [oo3d, item]


      "Snapshot object from a transformed Item as expected"
      "
      ,rX:0.001,rY:-0.0026247117550648683,rZ:31.93952531149623,sX:0.001,sY:-0.5000001,sZ:1345,tX:0.001,tY:-0.5000001,tZ:1345}
      "
      (oo3d, item) -> (JSON.stringify item.getSnapshot()).replace(/"/g, '').slice -119


      "Snapshot log from a transformed Item as expected"
      ", rX:0.001, rY:-0.0026247117550648683, rZ:31.93952531149623, sX:0.001, sY:-0.5000001, sZ:1345, tX:0.001, tY:-0.5000001, tZ:1345"
      (oo3d, item) -> item.getSnapshot('log').slice -127


      "Snapshot URI from a transformed Item as expected"
      "AzXBoEfEi1loEfEi1l"
      (oo3d, item) -> item.getSnapshot 'uri'


      "Use a snapshot log to reset a transformed Item"
      "1000 0100 0010 0001 - 0 0 0  1 1 1  0 0 0"
      (oo3d, item) ->
        item.setSnapshot 'm:[1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1], rX:0, rY:0, rZ:0, sX:1, sY:1, sZ:1, tX:0, tY:0, tZ:0'
        m = item.matTransform
        "#{m[0] }#{m[1] }#{m[2] }#{m[3] }
         #{m[4] }#{m[5] }#{m[6] }#{m[7] }
         #{m[8] }#{m[9] }#{m[10]}#{m[11]}
         #{m[12]}#{m[13]}#{m[14]}#{m[15]}
         - #{item.rX} #{item.rY} #{item.rZ}  #{item.sX} #{item.sY} #{item.sZ}  #{item.tX} #{item.tY} #{item.tZ}"


      "Use a snapshot log with whitespace removed, to reset a transformed Item"
      "1000 0100 0010 0001 - 0 0 0  1 1 1  0 0 0"
      (oo3d, item) ->
        item.setSnapshot 'm:[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],rX:0,rY:0,rZ:0,sX:1,sY:1,sZ:1,tX:0,tY:0,tZ:0'
        m = item.matTransform
        "#{m[0] }#{m[1] }#{m[2] }#{m[3] }
         #{m[4] }#{m[5] }#{m[6] }#{m[7] }
         #{m[8] }#{m[9] }#{m[10]}#{m[11]}
         #{m[12]}#{m[13]}#{m[14]}#{m[15]}
         - #{item.rX} #{item.rY} #{item.rZ}  #{item.sX} #{item.sY} #{item.sZ}  #{item.tX} #{item.tY} #{item.tZ}"


      "Use a snapshot URI to transform an Item"
      "1000 0100 0010 0001 - 0 6.280276425092929 0.5235987755982988  0.001 -0.5 1345  0.001 -0.5 1345"
      (oo3d, item) ->
        item.setSnapshot 'AzXBoEfEi1loEfEi1l'
        m = item.matTransform
        "#{m[0] }#{m[1] }#{m[2] }#{m[3] }
         #{m[4] }#{m[5] }#{m[6] }#{m[7] }
         #{m[8] }#{m[9] }#{m[10]}#{m[11]}
         #{m[12]}#{m[13]}#{m[14]}#{m[15]}
         - #{item.rX} #{item.rY} #{item.rZ}  #{item.sX} #{item.sY} #{item.sZ}  #{item.tX} #{item.tY} #{item.tZ}"




    ]












