Renderer.Wireframe
==================


#### Renders shapes as wireframes
@todo




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Renderer.Wireframe’s index in `main._all`
- `config <object>`  (optional) configuration and options

    class Renderer.Wireframe extends Renderer
      C: 'Renderer.Wireframe'
      toString: -> '[object Renderer.Wireframe]'


      constructor: (main, index, config={}) ->
        M = "/oo3d/src/renderer/class-renderer-wireframe.litcoffee
          Renderer.Wireframe##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `glData <WebGLBuffer>` (inherited)
#### `program <Program>` (inherited)
#### `camera <Camera>` (inherited)
#### `uMatCameraLoc <WebGLUniformLocation>` (inherited)
#### `meshes <array of Item.Meshes>` (inherited)




Properties
----------


