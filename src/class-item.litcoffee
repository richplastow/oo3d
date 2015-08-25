Item
====


#### An individual object which can be rendered

    class                           Item
      C: "/src/class-item.litcoffee:Item"
      toString: ->         "[object Item]"

      constructor: (@main, @index, config={}) ->
        M = "#{@C}:constructor()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}`config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Item. 

        if ªO != ªtype @main then throw TypeError "
          #{M}`main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` must be [object Oo3d] not #{@main}"


#### `index <integer>`
This Item’s index in the `main.items` array. 

        if ªN != ªtype @index then throw TypeError "
          #{M}`index` must be number not #{ªtype @index}"


#### `color <Float32Array>`
A color which can act as an ID. Useful for picking. 

        @color = pick.indexToColor @index # defined in /src/pick.coffee


#### `positionBuffer <WebGLBuffer>`
Xx. @todo describe

        @positionBuffer = @main.positionBuffers[config.positionI or 0]
        if ! @positionBuffer then throw Error "
          #{M}`config.positionI` #{config.positionI} does not exist"


#### `colorBuffer <WebGLBuffer>`
Xx. @todo describe

        @colorBuffer = @main.colorBuffers[config.colorI or 0]
        if ! @colorBuffer then throw Error "
          #{M}`config.colorI` #{config.colorI} does not exist"


#### `count <integer>`
Xx. @todo describe

        if @positionBuffer.count != @colorBuffer.count then throw Error "
          #{M}`config.positionI` mismatches config.colorI"
        @count = @positionBuffer.count


#### `renderMode <string>`
'POINTS', 'LINE_STRIP', 'TRIANGLES', etc. Equates to an integer in the `gl` 
object, eg `gl.TRIANGLES` is `4`. This integer becomes the `mode` argument 
passed to `gl.drawArrays()` when this Item is rendered.  
@todo override at the level of a Layer, and maybe at other levels too

        @renderMode = config.renderMode or 'TRIANGLES' # default if falsey
        if ! Item.validRenderMode[@renderMode] then throw Error "
          #{M}`config.renderMode` #{@renderMode} is not recognised by WebGL"


#### `sBlend and dBlend <integer|null>`
Xx. @todo describe

        if ! config.blend # any falsey value, or leave undefined
          @sBlend = null
          @dBlend = null
        else if ªA != ªtype config.blend then throw Error "
          #{M}If set, `config.blend` must be array not #{ªtype config.blend}"
        else
          if ! Item.validBlend[ config.blend[0] ] then throw Error "
            #{M}`config.blend[0]` is not recognised by WebGL"
          if ! Item.validBlend[ config.blend[1] ] then throw Error "
            #{M}`config.blend[1]` is not recognised by WebGL"
          @sBlend = @main.gl[ config.blend[0] ]
          @dBlend = @main.gl[ config.blend[1] ]


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
- format `<string>`  (optional) one of 'object' (default), 'log', 'uri'
- `<object|string>`  xx @todo describe

Create an object or string which describes the Item’s current state.  
@todo also `item.dBlend` etc, not just the transform state

      getSnapshot: (format) ->

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

        else if 'uri' == format

Return the uri snapshot. These functions are defined in /src/uri.litcoffee

          [
            uri.r2uri @rX
            uri.r2uri @rY
            uri.r2uri @rZ
            uri.s2uri @sX
            uri.s2uri @sY
            uri.s2uri @sZ
            uri.t2uri @tX
            uri.t2uri @tY
            uri.t2uri @tZ
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
- snapshot `<string|object>`  eg returned by `getSnapshot('object|log|uri')`

Xx. 

      setSnapshot: (snapshot) ->
        M = "#{@C}:setSnapshot()\n  "

Infer the format, 'object', 'log' or 'uri'. 

        format = ªtype snapshot
        if ªS == format
          format = if 'm:[' == snapshot.slice 0, 3 then 'log' else 'uri'

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

Record a uri snapshot into the Item, eg:  
AzXBoEfEi1loEfEi1l

        else if 'uri' == format

          isUC = A:1,B:1,C:1,D:1,E:1,F:1,G:1,H:1,I:1,J:1,K:1,L:1,M:1
                ,N:1,O:1,P:1,Q:1,R:1,S:1,T:1,U:1,V:1,W:1,X:1,Y:1,Z:1
          captureKeys = [
            'rX', 'rY', 'rZ',
            'sX', 'sY', 'sZ',
            'tX', 'tY', 'tZ'
          ]
          captureLengths = [
            2, 2, 2
            3, 3, 3
            3, 3, 3
          ]
          captureFns  = [
            uri.uri2r, uri.uri2r, uri.uri2r, 
            uri.uri2s, uri.uri2s, uri.uri2s, 
            uri.uri2t, uri.uri2t, uri.uri2t, 
          ]
          chI = 0; l = snapshot.length; captureI = 0
          while chI < l
            captureKey    = captureKeys[captureI]
            captureLength = captureLengths[captureI]
            captureFn     = captureFns[captureI]
            ch = snapshot[chI]
            if isUC[ch]
              chI++
              @[captureKey] = captureFn ch
            else
              @[captureKey] = captureFn snapshot.substr chI, captureLength
              chI += captureLength
            captureI++
          #@todo NEXT apply new values to matTransform

        #@todo accept object




Static Properties
-----------------


#### `Item.validRenderMode <object>`
Defines valid WebGL render-mode constants.  
Used by [/src/class-item.litcoffee:Item:constructor()](https://goo.gl/wIUN6Y)  

    Item.validRenderMode =
      'POINTS'        :1 # a single dot per vertex, so 10 vertices draws 10 dots
      'LINES'         :1 # lines between vertex pairs, 10 vertices draws 5 lines
      'LINE_STRIP'    :1 # lines between all vertices, 10 vertices draws 9 lines
      'LINE_LOOP'     :1 # as LINE_STRIP but connects last vertex back to first
      'TRIANGLES'     :1 # a triangle for each set of three consecutive vertices
      'TRIANGLE_STRIP':1 # vertex 4 adds a new triangle after the 1st is drawn
      'TRIANGLE_FAN'  :1 # like TRIANGLE_STRIP, but creates a fan shaped output


#### `validBlend <object>`
Defines valid WebGL blend constants.  
Used by [/src/class-item.litcoffee:Item:constructor()](https://goo.gl/uEqa8U)

    Item.validBlend =
      'ZERO'               :1
      # 0          0          0          0
      # Multiply all colors by 0
      'ONE'                :1
      # 1          1          1          1
      # Multiply all colors by 1
      'SRC_COLOR'          :1
      # Rs         Gs         Bs         As
      # Multiply by source color value
      'ONE_MINUS_SRC_COLOR':1
      # (1-Rs)     (1-Gs)     (1-Bs)     (1-As)
      # Multiply by 1 minus each color value
      'DST_COLOR'          :1
      # Rd         Gd         Bd         Ad
      # Multiply by destination color value
      'ONE_MINUS_DST_COLOR':1
      # (1-Rd)     (1-Gd)     (1-Bd)     (1-Ad)
      # Multiply by 1 minus each color value
      'SRC_ALPHA'          :1
      # As         As         As         As
      # Multiply all colors by source alpha value
      'ONE_MINUS_SRC_ALPHA':1
      # (1-As)     (1-As)     (1-As)     (1-As)
      # Multiply all colors by 1 minus source alpha value
      'DST_ALPHA'          :1
      # Ad         Ad         Ad         Ad
      # Multiply all colors by destination alpha value
      'ONE_MINUS_DST_ALPHA':1
      # (1-Ad)     (1-Ad)     (1-Ad)     (1-Ad)
      # Multiply all colors by 1 minus each alpha value
      'SRC_ALPHA_SATURATE' :1
      # min(As,Ad) min(As,Ad) min(As,Ad) 1
      # Multiply by the smaller of source or dest alpha value




