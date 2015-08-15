Item
====


#### An individual object which can be rendered

    class Item
      C: 'Item'
      toString: -> "[object #{@C}]"

      constructor: (@main, @index, config={}) ->
        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Item. 

        if ªO != ªtype @main then throw TypeError "
          `main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          `main` must be [object Oo3d] not #{@main}"


#### `index <integer>`
This Item’s index in the `main.items` array. 

        if ªN != ªtype @index then throw TypeError "
          `index` must be number not #{ªtype @index}"


#### `color <Float32Array>`
A color which can act as an ID. Useful for picking. 

        @color = pick.indexToColor @index # defined in /src/pick.coffee


#### `positionBuffer <WebGLBuffer>`
Xx. @todo describe

        @positionBuffer = @main.positionBuffers[config.positionI]
        if ! @positionBuffer then throw Error """
          config.positionI #{config.positionI} does not exist"""


#### `colorBuffer <WebGLBuffer>`
Xx. @todo describe

        @colorBuffer = @main.colorBuffers[config.colorI]
        if ! @colorBuffer then throw Error """
          config.colorI #{config.colorI} does not exist"""


#### `count <integer>`
Xx. @todo describe

        if @positionBuffer.count != @colorBuffer.count
          throw Error "config.positionI mismatches config.colorI"
        @count = @positionBuffer.count


#### `sBlend and dBlend <integer|null>`
Xx. @todo describe

* `ZERO`                 0          0          0          0  
                         Multiply by all colors by 0
* `ONE`                  1          1          1          1  
                         Multiply all colors by 1
* `SRC_COLOR`            Rs         Gs         Bs         As  
                         Multiply by source color value
* `ONE_MINUS_SRC_COLOR`  (1-Rs)     (1-Gs)     (1-Bs)     (1-As)  
                         Multiply by 1 minus each color value
* `DST_COLOR`            Rd         Gd         Bd         Ad  
                         Multiply by destination color value
* `ONE_MINUS_DST_COLOR`  (1-Rd)     (1-Gd)     (1-Bd)     (1-Ad)  
                         Multiply by 1 minus each color value
* `SRC_ALPHA`            As         As         As         As  
                         Multiply all colors by source alpha value
* `ONE_MINUS_SRC_ALPHA`  (1-As)     (1-As)     (1-As)     (1-As)  
                         Multiply all colors by 1 minus source alpha value
* `DST_ALPHA`            Ad         Ad         Ad         Ad  
                         Multiply all colors by destination alpha value
* `ONE_MINUS_DST_ALPHA`  (1-Ad)     (1-Ad)     (1-Ad)     (1-Ad)  
                         Multiply all colors by 1 minus each alpha value
* `SRC_ALPHA_SATURATE`   min(As,Ad) min(As,Ad) min(As,Ad) 1  
                         Multiply by the smaller of source or dest alpha value

        if ªA == ªtype config.blend
          @sBlend = @main.gl[ config.blend[0] ]
          @dBlend = @main.gl[ config.blend[1] ]
        else
          @sBlend = null
          @dBlend = null


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


#### `renderMode <string>`
'POINTS', 'LINE_STRIP', 'TRIANGLES', etc. Equates to an integer in the `gl` 
object, eg `gl.TRIANGLES` is `4`. This integer becomes the `mode` argument 
passed to `gl.drawArrays()` when this Item is rendered. 
@todo override at the level of a Scene

        @renderMode = config.renderMode or 'TRIANGLES' # default
        if ªN != ªtype @main.gl[@renderMode] then throw Error """
          `renderMode` #{@renderMode} is not recognised by WebGL"""




Methods
-------


#### `xx()`
Xx. 

      xx: ->




