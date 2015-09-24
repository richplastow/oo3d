Buffer
======


#### The base class for all vertex buffer objects, like Position and Color

- Contains a `WebGLBuffer` instance in the `data` property
- Each Item.Mesh must use one Buffer.Position
- Each Item.Mesh may optionally use one Buffer.Color
- A Buffer can be used by any number of Item.Meshes
- All Buffers are stored in the `main._all` array

@todo describe

    class Buffer
      C: 'Buffer'
      toString: -> '[object Buffer]'




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Buffer’s index in `main._all`
- `config <object>`  (optional) configuration, and in particular, `data`

@todo describe

      constructor: (@main, @index, config={}) ->
        M = "/oo3d/src/buffer/base-buffer.litcoffee
          Buffer##{+@index}()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Buffer. 

        if ªO != typeof @main then throw TypeError "
          #{M}`main` is #{ªtype @main} not object"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` is '#{@main}' not '[object Oo3d]'"


#### `index <integer>`
This Buffer’s index in `main._all`. 

        if ªN != typeof @index then throw TypeError "
          #{M}`index` is #{ªtype @index} not number"
        if ªMAX < @index or @index % 1 or 0 > @index then throw RangeError "
          #{M}`index` is #{@index} not 0 or a positive integer below 2^53"


Get a handy reference to the `gl` context. 

        gl = @main.gl


#### `glData <WebGLBuffer>`
@todo describe. 

        @glData = gl.createBuffer()
        gl.bindBuffer gl.ARRAY_BUFFER, @glData
        tData = ªtype config.data
        if ªU == tData 
          gl.bufferData gl.ARRAY_BUFFER, new Float32Array([]), gl.STATIC_DRAW
        else
          if ªA != tData then throw TypeError "
            #{M}`config.data` is #{tData} not array"
          if config.data.some isNaN then throw TypeError "
            #{M}`config.data` contains a non-numeric value" # @todo `if main.debug`
          gl.bufferData(
            gl.ARRAY_BUFFER,               # target
            new Float32Array(config.data), # size|data
            gl.STATIC_DRAW                 # usage STATIC / DYNAMIC / STREAM_DRAW
          )




Methods
-------


#### `browse()`
Xx. 

      browse: ->




