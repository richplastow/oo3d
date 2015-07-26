Buffer
======

@todo describe

    class Buffer
      C: 'Buffer'
      toString: -> "[object #{@C}]"

      constructor: (config={}, gl) ->

Record all config as instance properties. 

        @[k] = v for k,v of config




Properties
----------


#### `gl <WebGLRenderingContext>`
WebGL context, passed from the `Main` instance. 

        @gl = gl
        if 'webglrenderingcontext' != ªtype @gl then throw Error """
          gl must be WebGLRenderingContext not #{ªtype @gl}"""


#### `positions <WebGLBuffer>`
Xx. 

        if ªA != ªtype config.positions then throw Error """
          config.positions must be an array not #{ªtype config.positions}"""
        if config.positions.length % 3 then throw Error """
          config.positions.length must be divisible by 3"""
        @positions = @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @positions
        @gl.bufferData(
          @gl.ARRAY_BUFFER,
          new Float32Array(config.positions), @gl.STATIC_DRAW
        )


#### `colors <WebGLBuffer>`
Xx. 

        if ªU == ªtype config.colors
          config.colors = []
          config.colors.push 1 for i in [0..(config.positions.length/3*4-1)]
          ª config.colors
        else if ªA != ªtype config.colors then throw Error """
          config.colors must be an array not #{ªtype config.colors}"""
        else if config.colors.length % 4 then throw Error """
          config.colors.length must be divisible by 4"""
        else if (config.positions.length / 3 != config.colors.length / 4)
          throw Error "config.colors has an incorrect vertex count"
        @colors = @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @colors
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


#### `rotateX, rotateY, rotateZ <number>`
Keeps track of rotation currently applied to this buffer. All start at 0. 

        @rotateX = 0
        @rotateY = 0
        @rotateZ = 0


#### `translateX, translateY, translateZ <number>`
Keeps track of translation currently applied to this buffer. All start at 0. 

        @translateX = 0
        @translateY = 0
        @translateZ = 0




Methods
-------


#### `xx()`
Xx. 

      xx: ->




