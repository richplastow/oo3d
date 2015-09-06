Item
====


#### An individual 3D object which has coordinates

    class Item
      C: "/src/item/base-item.litcoffee:Item"
      toString: -> "[object Item]"

      constructor: (@main, @index, config={}) ->
        M = "/src/item/base-item.litcoffee:Item:constructor()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"




Instantiation Arguments
-----------------------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Item. 

        if ªO != ªtype @main then throw TypeError "
          #{M}`main` is #{ªtype @main} not object"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` is '#{@main}' not '[object Oo3d]'"


#### `index <integer>`
This Item’s index in, eg `main.cameras` or `main.meshes`. 

        if ªN != ªtype @index then throw TypeError "
          #{M}`index` is #{ªtype @index} not number"
        if ªMAX < @index or @index % 1 or 0 > @index then throw RangeError "
          #{M}`index` is #{@index} not 0 or a positive integer below 2^53"




Self-Assigned Properties
------------------------


#### `matTransform <Float32Array>`
The transformation-matrix currently applied to this Item. Starts at identity. 

        @matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])


#### `rX, rY, rZ <number>`
Keep track of rotation currently applied to this Item. All start at 0. 

        @rX = 0
        @rY = 0
        @rZ = 0


#### `sX, sY, sZ <number>`
Keep track of scale currently applied to this Item. All start at 1. 

        @sX = 1
        @sY = 1
        @sZ = 1


#### `tX, tY, tZ <number>`
Keep track of translation currently applied to this Item. All start at 0. 

        @tX = 0
        @tY = 0
        @tZ = 0




Methods
-------


#### `getSnapshot()`
- format `<string>`  (optional) one of 'object' (default), 'log', 'nwang'
- `<object|string>`  xx @todo describe

Create an object or string which describes the Item’s current state.  
@todo also `item.dBlend` etc, not just the transform state

      getSnapshot: (format) ->
        M = "/src/item/base-item.litcoffee:Item:getSnapshot()\n  "

        if 'log' == format

Return the log snapshot. 

          m = @matTransform
          "m:[#{m[0] },#{m[1] },#{m[2] },#{m[3] },
              #{m[4] },#{m[5] },#{m[6] },#{m[7] },
              #{m[8] },#{m[9] },#{m[10]},#{m[11]},
              #{m[12]},#{m[13]},#{m[14]},#{m[15]}],
           rX:#{@rX}, rY:#{@rY}, rZ:#{@rZ},
           sX:#{@sX}, sY:#{@sY}, sZ:#{@sZ},
           tX:#{@tX}, tY:#{@tY}, tZ:#{@tZ}"

        else if 'nwang' == format

Return the [nwang](http://goo.gl/gaumPj) snapshot. 

          sf3 = @main.nwang.sf3
          [
            sf3 @rX
            sf3 @rY
            sf3 @rZ
            sf3 @sX
            sf3 @sY
            sf3 @sZ
            sf3 @tX
            sf3 @tY
            sf3 @tZ
          ].join ''

        else # any other `format` is treated as 'object'

Clone, don’t reference, `matTransform`. 

          mat = new Float32Array 16
          mat.set @matTransform

Return the object snapshot. 

          mat: mat
          rX: @rX
          rY: @rY
          rZ: @rZ
          sX: @sX
          sY: @sY
          sZ: @sZ
          tX: @tX
          tY: @tY
          tZ: @tZ




#### `setSnapshot()`
- snapshot `<string|object>`  eg returned by `getSnapshot('object|log|nwang')`

Xx. 

      setSnapshot: (snapshot) ->
        M = "/src/item/base-item.litcoffee:Item:setSnapshot()\n  "

Infer the format, 'object', 'log' or 'nwang'. 

        format = ªtype snapshot
        if ªS == format
          format = if 'm:[' == snapshot.slice 0, 3 then 'log' else 'nwang'

Record a log snapshot into the Item, eg:  
m:[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],rX:0,rY:0,rZ:0,sX:1,sY:1,sZ:1,tX:0,tY:0,tZ:0

        if 'log' == format
          matches = snapshot.match(
            ///^              # start of string
            m:\[(.*)\]        # capture the sixteen matTransform values
            ,\s*rX:(-?[.\d]*) # capture rotation-x
            ,\s*rY:(-?[.\d]*) # capture rotation-y
            ,\s*rZ:(-?[.\d]*) # capture rotation-z
            ,\s*sX:(-?[.\d]*) # capture scale-x
            ,\s*sY:(-?[.\d]*) # capture scale-y
            ,\s*sZ:(-?[.\d]*) # capture scale-z
            ,\s*tX:(-?[.\d]*) # capture translate-x
            ,\s*tY:(-?[.\d]*) # capture translate-y
            ,\s*tZ:(-?[.\d]*) # capture translate-z
            $///              # end of string
          )

          if null == matches then throw Error "
          #{M}log-format snapshot is invalid"

          [snapshot, m, @rX, @rY, @rZ, @sX, @sY, @sZ, @tX, @tY, @tZ] = matches
          @matTransform = new Float32Array(m.split ',')

Record a nwang snapshot into the Item, eg:  
솆셢쵇솆밄펗솆밄펗

        else if 'nwang' == format

          nwang = @main.nwang
          #isUC = A:1,B:1,C:1,D:1,E:1,F:1,G:1,H:1,I:1,J:1,K:1,L:1,M:1
          #      ,N:1,O:1,P:1,Q:1,R:1,S:1,T:1,U:1,V:1,W:1,X:1,Y:1,Z:1
          captureKeys = [
            'rX', 'rY', 'rZ',
            'sX', 'sY', 'sZ',
            'tX', 'tY', 'tZ'
          ]
          captureLengths = [
            1, 1, 1
            1, 1, 1
            1, 1, 1
          ]
          captureFns  = [
            nwang.sf3, nwang.sf3, nwang.sf3, 
            nwang.sf3, nwang.sf3, nwang.sf3, 
            nwang.sf3, nwang.sf3, nwang.sf3, 
          ]
          chI = 0; l = snapshot.length; captureI = 0
          while chI < l
            captureKey    = captureKeys[captureI]
            captureLength = captureLengths[captureI]
            captureFn     = captureFns[captureI]
            ch = snapshot[chI]
            chI++
            @[captureKey] = captureFn ch
            #if isUC[ch]
            #  chI++
            #  @[captureKey] = captureFn ch
            #else
            #  @[captureKey] = captureFn snapshot.substr chI, captureLength
            #  chI += captureLength
            captureI++

Reset `matTransform` and apply new values to it. 

        @matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])
        @main.rotate     @rX, @rY, @rZ, @index
        @main.scale      @sX, @sY, @sZ, @index
        @main.translate  @tX, @tY, @tZ, @index


        #@todo accept object


