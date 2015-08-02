Buffer
======

@todo describe

    class Buffer
      C: 'Buffer'
      toString: -> "[object #{@C}]"

      constructor: (config={}, gl) ->




Properties
----------


#### `gl <WebGLRenderingContext>`
WebGL context, passed from the `Main` instance. 

        @gl = gl
        if 'webglrenderingcontext' != ªtype @gl then throw Error """
          gl must be WebGLRenderingContext not #{ªtype @gl}"""


#### `positionBuffer <WebGLBuffer>`
Xx. 

        if ªA != ªtype config.positions then throw Error """
          config.positions must be an array not #{ªtype config.positions}"""
        if config.positions.length % 3 then throw Error """
          config.positions.length must be divisible by 3"""
        @positionBuffer = @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @positionBuffer
        @gl.bufferData(
          @gl.ARRAY_BUFFER,
          new Float32Array(config.positions), @gl.STATIC_DRAW
        )


#### `colorBuffer <WebGLBuffer>`
Xx. 

        if ªU == ªtype config.colors
          config.colors = (1 for i in [0..(config.positions.length/3*4-1)])
        else if ªA != ªtype config.colors then throw Error """
          config.colors must be an array not #{ªtype config.colors}"""
        else if config.colors.length % 4 then throw Error """
          config.colors.length must be divisible by 4"""
        else if (config.positions.length / 3 != config.colors.length / 4)
          throw Error "config.colors has an incorrect vertex count"
        @colorBuffer = @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @colorBuffer
        @gl.bufferData(
          @gl.ARRAY_BUFFER,
          new Float32Array(config.colors), @gl.STATIC_DRAW
        )


#### `count <integer>`
Xx. 

        @count = config.positions.length / 3


#### `matTransform <array>`
The transformation-matrix currently applied to this buffer. Starts at identity. 

        @matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])


#### `rX, rY, rZ <number>`
Keeps track of rotation currently applied to this buffer. All start at 0. 

        @rX = 0
        @rY = 0
        @rZ = 0


#### `sX, sY, sZ <number>`
Keeps track of rotation currently applied to this buffer. All start at 1. 

        @sX = 1
        @sY = 1
        @sZ = 1


#### `tX, tY, tZ <number>`
Keeps track of translation currently applied to this buffer. All start at 0. 

        @tX = 0
        @tY = 0
        @tZ = 0




Methods
-------


#### `xx()`
Xx. 

      xx: ->




