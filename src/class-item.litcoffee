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
Keeps track of rotation currently applied to this Item. All start at 0. 

        @rX = 0
        @rY = 0
        @rZ = 0


#### `sX, sY, sZ <number>`
Keeps track of rotation currently applied to this Item. All start at 1. 

        @sX = 1
        @sY = 1
        @sZ = 1


#### `tX, tY, tZ <number>`
Keeps track of translation currently applied to this Item. All start at 0. 

        @tX = 0
        @tY = 0
        @tZ = 0




Methods
-------


#### `getSnapshot()`
Xx. 

      getSnapshot: ->




#### `setSnapshot()`
- `s <object>`  (optional) a snapshot of an Item

Xx. 

      setSnapshot: (s) ->




Static Properties
-----------------


#### `Item.validRenderMode <object>`
Defines valid WebGL render-mode constants.  
Used by /src/class-item.litcoffee:Item:constructor()  
@todo more

    Item.validRenderMode =
      'TRIANGLES'     :1
      'LINE_STRIP'    :1
      'POINTS'        :1


#### `validBlend <object>`
Defines valid WebGL blend constants.  
Used by /src/class-item.litcoffee:Item:constructor()

    Item.validBlend =
      'ZERO'                :1
      # 0          0          0          0
      # Multiply all colors by 0
      'ONE'                 :1
      # 1          1          1          1
      # Multiply all colors by 1
      'SRC_COLOR'           :1
      # Rs         Gs         Bs         As
      # Multiply by source color value
      'ONE_MINUS_SRC_COLOR' :1
      # (1-Rs)     (1-Gs)     (1-Bs)     (1-As)
      # Multiply by 1 minus each color value
      'DST_COLOR'           :1
      # Rd         Gd         Bd         Ad
      # Multiply by destination color value
      'ONE_MINUS_DST_COLOR' :1
      # (1-Rd)     (1-Gd)     (1-Bd)     (1-Ad)
      # Multiply by 1 minus each color value
      'SRC_ALPHA'           :1
      # As         As         As         As
      # Multiply all colors by source alpha value
      'ONE_MINUS_SRC_ALPHA' :1
      # (1-As)     (1-As)     (1-As)     (1-As)
      # Multiply all colors by 1 minus source alpha value
      'DST_ALPHA'           :1
      # Ad         Ad         Ad         Ad
      # Multiply all colors by destination alpha value
      'ONE_MINUS_DST_ALPHA' :1
      # (1-Ad)     (1-Ad)     (1-Ad)     (1-Ad)
      # Multiply all colors by 1 minus each alpha value
      'SRC_ALPHA_SATURATE'  :1
      # min(As,Ad) min(As,Ad) min(As,Ad) 1
      # Multiply by the smaller of source or dest alpha value




