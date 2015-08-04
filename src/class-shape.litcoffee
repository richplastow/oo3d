Shape
=====

#### An individual object which can appear in a Scene

    class Shape
      C: 'Shape'
      toString: -> "[object #{@C}]"

      constructor: (config={}, main) ->




Properties
----------


#### `gl <WebGLRenderingContext>`
WebGL context, passed from the `Main` instance. 

        @gl = main.gl
        if 'webglrenderingcontext' != ªtype @gl then throw Error """
          main.gl must be WebGLRenderingContext not #{ªtype @gl}"""


#### `positionBuffer <WebGLBuffer>`
Xx. @todo describe

        @positionBuffer = main.positionBuffers[config.positionIndex]
        if ! @positionBuffer then throw Error """
          config.positionIndex #{config.positionIndex} does not exist"""


#### `colorBuffer <WebGLBuffer>`
Xx. @todo describe

        @colorBuffer = main.colorBuffers[config.colorIndex]
        if ! @colorBuffer then throw Error """
          config.colorIndex #{config.colorIndex} does not exist"""


#### `count <integer>`
Xx. @todo describe

        if @positionBuffer.count != @colorBuffer.count
          ª @positionBuffer.count, '!=', @colorBuffer.count
          throw Error "config.positionIndex mismatches config.colorIndex"
        @count = @positionBuffer.count


#### `matTransform <Float32Array>`
The transformation-matrix currently applied to this shape. Starts at identity. 

        @matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])


#### `rX, rY, rZ <number>`
Keeps track of rotation currently applied to this shape. All start at 0. 

        @rX = 0
        @rY = 0
        @rZ = 0


#### `sX, sY, sZ <number>`
Keeps track of rotation currently applied to this shape. All start at 1. 

        @sX = 1
        @sY = 1
        @sZ = 1


#### `tX, tY, tZ <number>`
Keeps track of translation currently applied to this shape. All start at 0. 

        @tX = 0
        @tY = 0
        @tZ = 0


#### `renderMode <string>`
'POINTS', 'LINE_STRIP', 'TRIANGLES', etc. Equates to an integer in the `gl` 
object, eg `gl.TRIANGLES` is `4`. This integer becomes the `mode` argument 
passed to `gl.drawArrays()` when this Shape is rendered. 
@todo override at the level of a Scene

        @renderMode = config.renderMode or 'TRIANGLES' # default
        if ªN != ªtype @gl[@renderMode] then throw Error """
          `renderMode` #{@renderMode} is not recognised by WebGL"""




Methods
-------


#### `xx()`
Xx. 

      xx: ->




