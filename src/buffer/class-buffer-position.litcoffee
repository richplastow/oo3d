Buffer.Position
===============


#### Vertex position buffer, used to contain an Item.Mesh’s (x,y,z) coords

- Contains a `WebGLBuffer` instance in the `data` property
- Each Item.Mesh must use one Buffer.Position
- A Buffer.Position can be used by any number of Item.Meshes
- All Buffer.Positions are stored in the `main._all` array




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Buffer.Position’s index in `main._all`
- `config <object>`  (optional) configuration, and in particular, `data`

    class Buffer.Position extends Buffer
      C: 'Buffer.Position'
      toString: -> '[object Buffer.Position]'


      constructor: (main, index, config={}) ->
        M = "/oo3d/src/buffer/class-buffer-position.litcoffee
          Buffer.Position##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `glData <WebGLBuffer>` (inherited)




Properties
----------


#### `count <integer>`
The number of vertices in this Buffer.Position. 

        if ªU == typeof config.data
          @count = 0
        else
          if config.data.length % 3 then throw RangeError "
            #{M}`config.data.length` #{config.data.length} not divisible by 3"
          @count = config.data.length / 3




Methods
-------


#### `browse()`
Xx. 

      browse: ->




