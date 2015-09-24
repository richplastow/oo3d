Item
====


#### The base class for discrete elements in 3D space, like Meshes and Cameras

@todo describe

    class Item
      C: 'Item'
      toString: -> '[object Item]'




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Item’s index in `main._all`
- `config <object>`  (optional) configuration and options

@todo describe

      constructor: (@main, @index, config={}) ->
        M = "/oo3d/src/item/base-item.litcoffee
          Item##{+@index}()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"




Instantiation Arguments
-----------------------


#### `main <Main>`
A reference to the main Oo3d instance which created this Item. 

        if ªO != typeof @main then throw TypeError "
          #{M}`main` is #{ªtype @main} not object"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` is '#{@main}' not '[object Oo3d]'"


#### `index <integer>`
This Item’s index in `main._all`. 

        if ªN != typeof @index then throw TypeError "
          #{M}`index` is #{ªtype @index} not number"
        if ªMAX < @index or @index % 1 or 0 > @index then throw RangeError "
          #{M}`index` is #{@index} not 0 or a positive integer below 2^53"


#### `oT <string>`
This Item’s order-of-transform. Changes the way `edit()` calculates `mT`. 
Defaults to 'trs', which transforms in the order translate > rotate > scale. 

        @oT = config.oT or 'trs'
        if ! {'trs':1,'rts':1,'srt':1}[@oT] then throw RangeError "
          #{M}Optional `config.oT` is not 'trs|rts|srt'"




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




BREAD API Methods
-----------------


#### `browse()`
- `search <int|array|string>`  (optional) xx @todo describe
- `<array>`                    search results @todo describe

Xx. 

      browse: (search) ->
        M = "/oo3d/src/item/base-item.litcoffee
          Item##{@index}:browse()\n  "
        return []




#### `read()`
- `format <string>`  (optional) one of 'object' (default), 'log' or 'nwang'
- `<object|string>`  xx @todo describe

Creates an object or string which describes the Item’s current state. 

      read: (format) ->
        M = "/oo3d/src/item/base-item.litcoffee
          Item##{@index}:read()\n  "

If `format` is not set (or is the string 'object'), return an object snapshot 
of the Item’s current state. 

        if ªU == typeof format or 'object' == format

          mTCopy = new Float32Array 16
          mTCopy.set @mT # copy, don’t reference, `mT`

          { index: @index, mT: mTCopy, 
          rX: @rX, rY: @rY, rZ: @rZ, 
          sX: @sX, sY: @sY, sZ: @sZ, 
          tX: @tX, tY: @tY, tZ: @tZ }

If `format` is 'log', return a simple string snapshot. 

        else if 'log' == format
          mT = @mT

          "i #{@index}
           mT #{mT[0] } #{mT[1] } #{mT[2] } #{mT[3] }
              #{mT[4] } #{mT[5] } #{mT[6] } #{mT[7] }
              #{mT[8] } #{mT[9] } #{mT[10]} #{mT[11]}
              #{mT[12]} #{mT[13]} #{mT[14]} #{mT[15]}
           r #{@rX} #{@rY} #{@rZ} s #{@sX} #{@sY} #{@sZ} t #{@tX} #{@tY} #{@tZ}"

If `format` is 'nwang', return an efficient UTF-16 snapshot. See the 
[Nwang library](http://goo.gl/gaumPj) for details. 

        else if 'nwang' == format
          mT = @mT
          sf3 = @main.nwang.sf3

          "#{sf3 @index}" +
          "#{sf3 mT[0] }#{sf3 mT[1] }#{sf3 mT[2] }#{sf3 mT[3] }" +
          "#{sf3 mT[4] }#{sf3 mT[5] }#{sf3 mT[6] }#{sf3 mT[7] }" +
          "#{sf3 mT[8] }#{sf3 mT[9] }#{sf3 mT[10]}#{sf3 mT[11]}" +
          "#{sf3 mT[12]}#{sf3 mT[13]}#{sf3 mT[14]}#{sf3 mT[15]}" +
          "#{sf3 @rX}#{sf3 @rY}#{sf3 @rZ}" +
          "#{sf3 @sX}#{sf3 @sY}#{sf3 @sZ}" +
          "#{sf3 @tX}#{sf3 @tY}#{sf3 @tZ}"

Otherwise, throw an exception. 

        else if ªS == typeof format
          throw RangeError "
            #{M}Optional `format` is not 'object|log|nwang'"

        else
          throw TypeError "
            #{M}Optional `format` is #{ªtype format} not string|object"




#### `edit()`
- `set   <object|string>`  (optional) set properties
- `delta <object|string>`  (optional) modify properties
- `<object>`               this Item, to allow chaining

Modifies the Item’s current state. 

      edit: (set, delta) ->
        M = "/oo3d/src/item/base-item.litcoffee
          Item##{@index}:edit()\n  "


##### Setup

        tSet   = ªtype set
        tDelta = ªtype delta
        tmp    = {}    # if an error is thrown, item state will not be changed
        stale  = false # if `true`, `mT` will need to be recalculated


##### `set`

If `set` is `null` or `undefined`, copy the Item’s `rX..tZ` values into `tmp`. 

        if ªU == tSet or ªX == tSet
          for key in ['rX','rY','rZ','sX','sY','sZ','tX','tY','tZ']
            tmp[key] = @[key]

If `set` is an object, copy its properties into `tmp`. 

        else
          if ªO == tSet

            if ªU != typeof set.index and @index != set.index
              throw RangeError "#{M}`this.index` cannot be altered by `set.index`"

            for key in ['rX','rY','rZ','sX','sY','sZ','tX','tY','tZ']
              val = set[key]
              tVal = typeof val
              if ªU == tVal
                tmp[key] = @[key] # may need a value for `delta` to transform
              else
                if ªN != tVal then throw TypeError "
                  #{M}`set.#{key}` is #{ªtype val} not number"
                if isNaN val then throw TypeError "
                  #{M}`set.#{key}` is NaN"
                tmp[key] = val

            if set.mT # we trust that `set.mT` is an accurate result of `rX..tZ`
              tMT = ªtype set.mT
              if ªA != tMT.slice -5 then throw TypeError "
                #{M}`set.TtM` is #{tMT} not array|*Array"
              if 16 != set.mT.length then throw RangeError "
                #{M}`set.TtM` has #{set.mT.length} elements not 16"
              tmp.mT = new Float32Array 16
              tmp.mT.set set.mT # copy, don’t reference
            else
              stale = true

Throw an error for any type of `set` other than `object|string|undefined|null`. 

          else if ªS != tSet then throw TypeError "
            #{M}Optional `set` is #{tSet} not #{ªS}|object"

If `set` is the special 'reset' string, restore the Item to its original state. 
We reset `tmp` here, so that the `delta` argument can modify it. `tmp` will be 
copied to the Item’s `rX..tZ` properties in the ‘Finish up’ section below. 

          else if 'reset' == set
            @reset tmp # note `Item.Camera:reset()` has a special `tZ` value


If `set` appears to be an 'nwang' string, parse it into `tmp`.  
9 chars:  `'셼셼셼죨죨죨셼셼셼'`  
26 chars: `'셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨솆셢쵇솆밄첀솆밄첀'`

          else if 0xAFE8 < set.charCodeAt 0
            sf3 = @main.nwang.sf3

            if 9 == set.length
              [tmp.rX,tmp.rY,tmp.rZ,tmp.sX,tmp.sY,tmp.sZ,tmp.tX,tmp.tY,tmp.tZ] =
                +sf3 char for char in set.split ''
              stale = true

            else if 26 == set.length
              chars = set.split ''

              if @index != +sf3 chars[0] then throw RangeError "
                #{M}`this.index` cannot be altered by passing `set` an 'nwang'"

              tmp.mT = new Float32Array( +sf3 chars[i] for i in [1..16] )

              [tmp.rX,tmp.rY,tmp.rZ,tmp.sX,tmp.sY,tmp.sZ,tmp.tX,tmp.tY,tmp.tZ] =
                +sf3 chars[i] for i in [17..25]

            else throw RangeError "
              #{M}`set` appears to be 'nwang' but is #{set.length} characters"

If `set` appears to be a 'log' string, parse it into `tmp`.  
9 chars:  `'r 0 0 0 s 1 1 1 t 0 0 0'`  
26 chars: `'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'`

          else
            vals = set.split ' '

            if 'rst' == vals[0] + vals[4] + vals[8]
              [tmp.rX,tmp.rY,tmp.rZ,tmp.sX,tmp.sY,tmp.sZ,tmp.tX,tmp.tY,tmp.tZ] =
                for i in [1,2,3,5,6,7,9,10,11]
                  val = +vals[i]
                  unless isNaN val then val else throw RangeError "
                    #{M}`set` appears to be 9-char 'log' with non-numeric values"
              stale = true

            else if 'imTrst' == vals[0]+vals[2]+vals[19]+vals[23]+vals[27]

              if @index != +vals[1] then throw RangeError "
                #{M}`this.index` cannot be altered by passing `set` a 'log'"

              tmp.mT = new Float32Array(vals[i] for i in [3..18])

              [tmp.rX,tmp.rY,tmp.rZ,tmp.sX,tmp.sY,tmp.sZ,tmp.tX,tmp.tY,tmp.tZ] =
                for i in [20,21,22,24,25,26,28,29,30]
                  val = +vals[i]
                  unless isNaN val then val else throw RangeError "
                    #{M}`set` appears to be 26-char 'log' with non-numeric values"

            else throw RangeError "
              #{M}Optional `set` is string but not 'reset' or log|nwang format"


##### `delta`

If the `delta` argument has been passed in, parse it and set `stale` to true. 

        if ªU != tDelta
          stale = true

If `delta` is an object, use its properties to transform the Item. 

          if ªO == tDelta

            for key in ['rX','rY','rZ','sX','sY','sZ','tX','tY','tZ']
              val = delta[key]
              tVal = typeof val
              if ªU != tVal
                if ªN != tVal then throw TypeError "
                  #{M}`delta.#{key}` is #{ªtype val} not number"
                if isNaN val then throw TypeError "
                  #{M}`delta.#{key}` is NaN"
                if 's' == key.charAt 0
                  tmp[key] *= val # scale
                else
                  tmp[key] += val # rotate or transform

If `delta` appears to be an 'nwang' string, parse it to transform the Item.  
9 chars:  `'셼셼셼죨죨죨셼셼셼'`  

          else if ªS == tDelta and 0xAFE8 < delta.charCodeAt 0
            sf3 = @main.nwang.sf3

            if 9 == delta.length
              for key,i in ['rX','rY','rZ','sX','sY','sZ','tX','tY','tZ']
                val = +sf3 delta.charAt i
                if 's' == key.charAt 0
                  tmp[key] *= val # scale
                else
                  tmp[key] += val # rotate or transform

            else throw RangeError "
              #{M}`delta` appears to be 'nwang' but is #{delta.length} characters"

If `delta` appears to be a 'log' string, parse it to transform the Item.  
9 chars:  `'r 0 0 0 s 1 1 1 t 0 0 0'` 

          else if ªS == tDelta
            vals = delta.split ' '

            if 'rst' == vals[0] + vals[4] + vals[8]
              keys = ['-','rX','rY','rZ','-','sX','sY','sZ','-','tX','tY','tZ']
              for i in [1,2,3,5,6,7,9,10,11]
                key =  keys[i]
                val = +vals[i]
                unless isNaN val then throw RangeError "
                  #{M}`delta` appears to be 9-char 'log' with non-numeric values"
                if 5 <= i and 7 >= i
                  tmp[key] *= val # scale
                else
                  tmp[key] += val # rotate or transform

            else throw RangeError "
              #{M}Optional `delta` is a string, but not 'log|nwang' format"

Throw an exception for any type of `delta` other than `undefined` or `null`. 

          else if ªX != tDelta then throw TypeError "
            #{M}Optional `delta` is #{tDelta} not string|object"


##### Finish up

Did not throw an error, so write the new `rX..tZ` values to the Item’s state. 

        @[key] = val for key,val of tmp

Rebuild the transformation-matrix, if not explicitly set in the `set` argument. 

        if stale

          rXc = Math.cos @rX
          rXs = Math.sin @rX
          rYs = Math.sin @rY
          rYc = Math.cos @rY
          rZs = Math.sin @rZ
          rZc = Math.cos @rZ

Transform in the order translate > rotate > scale

          if 'trs' == @oT

            @mT = new Float32Array [
               rYc * rZc * @sX                           # 0
              (rXc * rZs  +  rXs * rYs * rZc) * @sX      # 1
              (rXs * rZs  -  rXc * rYs * rZc) * @sX      # 2
              0                                          # 3
              -rYc * rZs * @sY                           # 4
              (rXc * rZc  -  rXs * rYs * rZs) * @sY      # 5
              (rXs * rZc  +  rXc * rYs * rZs) * @sY      # 6
              0                                          # 7
               rYs * @sZ                                 # 8
              -rXs * rYc * @sZ                           # 9
               rXc * rYc * @sZ                           # 10
              0                                          # 11
              @tX                                        # 12
              @tY                                        # 13
              @tZ                                        # 14
              1                                          # 15
            ]

Transform in the order scale > rotate > translate

          else if 'srt' == @oT

            @mT = new Float32Array [
               rYc * rZc * @sX                           # 0
              (rXc * rZs  +  rXs * rYs * rZc) * @sY      # 1
              (rXs * rZs  -  rXc * rYs * rZc) * @sZ      # 2
              0                                          # 3
              -rYc * rZs * @sX                           # 4
              (rXc * rZc  -  rXs * rYs * rZs) * @sY      # 5
              (rXs * rZc  +  rXc * rYs * rZs) * @sZ      # 6
              0                                          # 7
               rYs * @sX                                 # 8
              -rXs * rYc * @sY                           # 9
               rXc * rYc * @sZ                           # 10
              0                                          # 11
              99, 99, 99                                 # updated below
              1                                          # 15
            ]

            @mT[12] = @mT[0] * @tX  +  @mT[4] * @tY  +  @mT[8]  * @tZ
            @mT[13] = @mT[1] * @tX  +  @mT[5] * @tY  +  @mT[9]  * @tZ
            @mT[14] = @mT[2] * @tX  +  @mT[6] * @tY  +  @mT[10] * @tZ

Transform in the order rotate > translate > scale

          else if 'rts' == @oT #@todo squash the code below 

            a = new Float32Array([
              1,   0,   0,   0
              0,   1,   0,   0
              0,   0,   1,   0
              0,   0,   0,   1
            ])

Rotate X. 

            a10 = a[4]  # always 0
            a11 = a[5]  # always 1
            a12 = a[6]  # always 0
            a13 = a[7]  # always 0
            a20 = a[8]  # always 0
            a21 = a[9]  # always 0
            a22 = a[10] # always 1
            a23 = a[11] # always 0

            a[4]  = a10 * rXc  +  a20 * rXs # always 0
            a[5]  = a11 * rXc  +  a21 * rXs # always rXc
            a[6]  = a12 * rXc  +  a22 * rXs # always rXs
            a[7]  = a13 * rXc  +  a23 * rXs # always 0
            a[8]  = a20 * rXc  -  a10 * rXs # always 0
            a[9]  = a21 * rXc  -  a11 * rXs # always -rXs
            a[10] = a22 * rXc  -  a12 * rXs # always rXc
            a[11] = a23 * rXc  -  a13 * rXs # always 0

Rotate Y. 

            a00 = a[0]  # always 1
            a01 = a[1]  # always 0
            a02 = a[2]  # always 0
            a03 = a[3]  # always 0
            a20 = a[8]  # always 0
            a21 = a[9]  # -rXs, from previous op
            a22 = a[10] # rXc, from previous op
            a23 = a[11] # always 0

            a[0]  = a00 * rYc  -  a20 * rYs # always rYc
            a[1]  = a01 * rYc  -  a21 * rYs # -(-rXs * rYs)
            a[2]  = a02 * rYc  -  a22 * rYs # -( rXc * rYs)
            a[3]  = a03 * rYc  -  a23 * rYs # always 0
            a[8]  = a00 * rYs  +  a20 * rYc # rYs
            a[9]  = a01 * rYs  +  a21 * rYc # -rXs * rYc
            a[10] = a02 * rYs  +  a22 * rYc #  rXc * rYc
            a[11] = a03 * rYs  +  a23 * rYc # always 0

Rotate Z. 

            a00 = a[0] # always rYc
            a01 = a[1] # -(-rXs * rYs)
            a02 = a[2] # -( rXc * rYs)
            a03 = a[3] # always 0
            a10 = a[4] # always 0
            a11 = a[5] # always rXc
            a12 = a[6] # always rXs
            a13 = a[7] # always 0

            a[0] = a00 * rZc  +  a10 * rZs # rYc * rZc
            a[1] = a01 * rZc  +  a11 * rZs # (-(-rXs * rYs) * rZc) + (rXc * rZs)
            a[2] = a02 * rZc  +  a12 * rZs # (-( rXc * rYs) * rZc) + (rXs * rZs)
            a[3] = a03 * rZc  +  a13 * rZs # always 0
            a[4] = a10 * rZc  -  a00 * rZs # -(rYc * rZs)
            a[5] = a11 * rZc  -  a01 * rZs # (rXc * rZc) - (-(-rXs * rYs) * rZs)
            a[6] = a12 * rZc  -  a02 * rZs # (rXs * rZc) - (-( rXc * rYs) * rZs)
            a[7] = a13 * rZc  -  a03 * rZs # always 0

Translate. 

            a[12] = a[0] * @tX + a[4] * @tY + a[8]  * @tZ + a[12]
            a[13] = a[1] * @tX + a[5] * @tY + a[9]  * @tZ + a[13]
            a[14] = a[2] * @tX + a[6] * @tY + a[10] * @tZ + a[14]
            a[15] = a[3] * @tX + a[7] * @tY + a[11] * @tZ + a[15] # always 1

Scale. 

            a[0]  *= @sX
            a[1]  *= @sX
            a[2]  *= @sX
            a[3]  *= @sX #@todo needed?

            a[4]  *= @sY
            a[5]  *= @sY
            a[6]  *= @sY
            a[7]  *= @sY #@todo needed?

            a[8]  *= @sZ
            a[9]  *= @sZ
            a[10] *= @sZ
            a[11] *= @sZ #@todo needed?

            @mT = a

@todo allow more values for `oT`. 

Allow chaining. 

        return @




#### `reset()`
- `subject <object>`  xx @todo describe
- `<object>`          the reset object

Resets properties on the given object.  
Used by `Item:edit('reset')`. 

      reset: (subject) ->
        M = "/oo3d/src/item/base-item.litcoffee
          Item##{@index}:reset()\n  "

        subject.mT = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])
        subject.rX = 0
        subject.rY = 0
        subject.rZ = 0
        subject.sX = 1
        subject.sY = 1
        subject.sZ = 1
        subject.tX = 0
        subject.tY = 0
        subject.tZ = 0
        subject




Private Functions
-----------------

      xx = ->


    ;



