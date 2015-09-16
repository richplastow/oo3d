Buffer.Color
============


#### Vertex color buffer, used to contain an Item.Mesh’s (r,g,b,a) colors

- Contains a `WebGLBuffer` instance in the `data` property
- Each Item.Mesh can optionally use one Buffer.Color
- A Buffer.Color can be used by any number of Item.Meshes
- All Buffer.Colors are stored in the `main._all` array




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Buffer.Color’s index in `main._all`
- `config <object>`  (optional) configuration, and in particular, `data`

    class Buffer.Color extends Buffer
      C: 'Buffer.Color'
      toString: -> '[object Buffer.Color]'


      constructor: (main, index, config={}) ->
        M = "/oo3d/src/buffer/class-buffer-color.litcoffee
          Buffer.Color##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `glData <WebGLBuffer>` (inherited)




Properties
----------


#### `count <integer>`
The number of vertices in this Buffer.Color. 

        if ªU == typeof config.data
          @count = 0
        else
          if config.data.length % 4 then throw RangeError "
            #{M}`config.data.length` #{config.data.length} not divisible by 4"
          #@todo test for invalid values < 0 or > 0 ... `if main.debug`
          @count = config.data.length / 4




Methods
-------


#### `browse()`
Xx. 

      browse: ->




