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


#### `mT <Float32Array>`
The transformation-matrix currently applied to this Item. Starts at identity. 

        @mT = new Float32Array([
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


#### `dump()`
- formatOrState `<string|object>`  (optional) defaults to 'object'
- `<object|string>`                xx @todo describe

Either create an object/string which describes the Item’s current state, or 
else change the Item’s state to match a given object/string.  

      dump: (formatOrState) ->
        M = "/src/item/base-item.litcoffee:Item:dump()\n  "
        type = ªtype formatOrState


If `formatOrState` is not set (or is the string 'object'), return an object 
snapshot of the Item’s current state. 

        if ªU == type or 'object' == formatOrState # defaults to 'object'
          mTClone = new Float32Array 16
          mTClone.set @mT # clone, don’t reference, `mT`

          index: @index
          mT: mTClone
          rX: @rX
          rY: @rY
          rZ: @rZ
          sX: @sX
          sY: @sY
          sZ: @sZ
          tX: @tX
          tY: @tY
          tZ: @tZ

If `formatOrState` is not a string, throw an exception. 

        else if ªS != type
          throw TypeError "
            #{M}Optional `formatOrState` is #{type} not string|object"

If `formatOrState` is the string 'log', return a minimal looking snapshot. 

        else if 'log' == formatOrState
          mT = @mT

          "i #{@index}
           mT #{mT[0] } #{mT[1] } #{mT[2] } #{mT[3] }
              #{mT[4] } #{mT[5] } #{mT[6] } #{mT[7] }
              #{mT[8] } #{mT[9] } #{mT[10]} #{mT[11]}
              #{mT[12]} #{mT[13]} #{mT[14]} #{mT[15]}
           r #{@rX} #{@rY} #{@rZ}
           s #{@sX} #{@sY} #{@sZ}
           t #{@tX} #{@tY} #{@tZ}"

If `formatOrState` is 'nwang', return an efficient UTF-16 snapshot. See the 
[Nwang library](http://goo.gl/gaumPj) for details. 

        else if 'nwang' == formatOrState
          mT = @mT
          sf3 = @main.nwang.sf3

          [
            sf3 @index
            sf3 mT[0]
            sf3 mT[1]
            sf3 mT[2]
            sf3 mT[3]
            sf3 mT[4]
            sf3 mT[5]
            sf3 mT[6]
            sf3 mT[7]
            sf3 mT[8]
            sf3 mT[9]
            sf3 mT[10]
            sf3 mT[11]
            sf3 mT[12]
            sf3 mT[13]
            sf3 mT[14]
            sf3 mT[15]
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

Update Item state if `formatOrState` looks like `dump('log')` output, eg:  
`i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0`

        else if 'i ' == formatOrState.slice 0, 2
          values = formatOrState.split ' '

          if @index != +values[1] then throw TypeError "
            #{M}`index` must not be altered by 'log'"

          @mT = new Float32Array(
            values[i] for i in [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
          )

          #if ªN == matches then throw Error "
          #  #{M}`formatOrState` looks like `dump('log')` output, but malformed"

          [@rX, @rY, @rZ, @sX, @sY, @sZ, @tX, @tY, @tZ] =
            +values[i] for i in [20,21,22,24,25,26,28,29,30]

          return @ # allow chaining

Update Item state if `formatOrState` looks like `dump('nwang')` output, eg:  
`셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼죨죨죨셼셼셼`

        else if 0xAFE8 < formatOrState.charCodeAt 0
          values = formatOrState.split ''
          sf3 = @main.nwang.sf3

          if @index != +sf3 values[0] then throw TypeError "
            #{M}`index` must not be altered by 'nwang'"

          @mT = new Float32Array(
            +sf3 values[i] for i in [1..16]
          )

          [@rX, @rY, @rZ, @sX, @sY, @sZ, @tX, @tY, @tZ] =
            +sf3 values[i] for i in [17..25]

Otherwise, throw an exception. 

        else
          throw RangeError "
            #{M}Optional `formatOrState` is not a valid string or object"




#### `getSnapshot()`
- format `<string>`  (optional) one of 'object' (default), 'log', 'nwang'
- `<object|string>`  xx @todo describe

Create an object or string which describes the Item’s current state.  
@todo also `item.dBlend` etc, not just the transform state

      getSnapshot: (format) ->
        M = "/src/item/base-item.litcoffee:Item:getSnapshot()\n  "

Return an object snapshot. 

        if ªU == typeof format or 'object' == format # defaults to 'object'

Clone, don’t reference, `mT`. 

          mT = new Float32Array 16
          mT.set @mT

          mT: mT
          rX: @rX
          rY: @rY
          rZ: @rZ
          sX: @sX
          sY: @sY
          sZ: @sZ
          tX: @tX
          tY: @tY
          tZ: @tZ

Return a log snapshot. 

        else if 'log' == format

          m = @mT
          "m:[#{m[0] },#{m[1] },#{m[2] },#{m[3] },
              #{m[4] },#{m[5] },#{m[6] },#{m[7] },
              #{m[8] },#{m[9] },#{m[10]},#{m[11]},
              #{m[12]},#{m[13]},#{m[14]},#{m[15]}],
           rX:#{@rX}, rY:#{@rY}, rZ:#{@rZ},
           sX:#{@sX}, sY:#{@sY}, sZ:#{@sZ},
           tX:#{@tX}, tY:#{@tY}, tZ:#{@tZ}"

Return a minimal snapshot. 

        else if 'minimal' == format

          m = @mT
          "m:[#{m[0] },#{m[1] },#{m[2] },#{m[3] },
              #{m[4] },#{m[5] },#{m[6] },#{m[7] },
              #{m[8] },#{m[9] },#{m[10]},#{m[11]},
              #{m[12]},#{m[13]},#{m[14]},#{m[15]}],
           rX:#{@rX}, rY:#{@rY}, rZ:#{@rZ},
           sX:#{@sX}, sY:#{@sY}, sZ:#{@sZ},
           tX:#{@tX}, tY:#{@tY}, tZ:#{@tZ}"

        else if 'nwang' == format

Return an [nwang](http://goo.gl/gaumPj) snapshot. 

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

Otherwise, throw an exception. 

        else if ªS != ªtype format
          throw TypeError "
            #{M}Optional `format` is #{ªtype format} not string"

        else
          throw RangeError "
            #{M}Optional `format` is not 'object|log|nwang'"




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
            ///^                    # start of string
            m:\[([-+.\d,\s]+)\]     # capture the sixteen matTransform values
            ,\s*rX:([-+]?\d*\.?\d*) # capture rotate-x
            ,\s*rY:([-+]?\d*\.?\d*) # capture rotate-y
            ,\s*rZ:([-+]?\d*\.?\d*) # capture rotate-z
            ,\s*sX:([-+]?\d*\.?\d*) # capture scale-x
            ,\s*sY:([-+]?\d*\.?\d*) # capture scale-y
            ,\s*sZ:([-+]?\d*\.?\d*) # capture scale-z
            ,\s*tX:([-+]?\d*\.?\d*) # capture translate-x
            ,\s*tY:([-+]?\d*\.?\d*) # capture translate-y
            ,\s*tZ:([-+]?\d*\.?\d*) # capture translate-z
            $///                    # end of string
          )

          if null == matches then throw Error "
            #{M}`snapshot`, which looks like 'log' format, is malformed"

          [snapshot, m, @rX, @rY, @rZ, @sX, @sY, @sZ, @tX, @tY, @tZ] =
            +match for match in matches # convert `rX ... tZ` to numbers
          @mat = new Float32Array(matches[1].split ',')

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

Reset the transformation-matrix and apply new values to it. 

          @mT = new Float32Array([
            1,  0,  0,  0
            0,  1,  0,  0
            0,  0,  1,  0
            0,  0,  0,  1
          ])
          @main.rotate     @rX, @rY, @rZ, @index
          @main.scale      @sX, @sY, @sZ, @index
          @main.translate  @tX, @tY, @tZ, @index


        #@todo accept object

        return @ # allows chaining


