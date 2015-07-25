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
        @colors = @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @colors
        @gl.bufferData(
          @gl.ARRAY_BUFFER,
          new Float32Array(config.colors), @gl.STATIC_DRAW
        )




Methods
-------


#### `xx()`
Xx. 
      xx: ->




