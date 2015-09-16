Layer.Simple
============


#### A basic Layer




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Layer.Simple’s index in `main._all`
- `config <object>`  (optional) configuration and options

    class Layer.Simple extends Layer
      C: 'Layer.Simple'
      toString: -> '[object Layer.Simple]'


      constructor: (main, index, config={}) ->
        M = "/oo3d/src/layer/class-layer-simple.litcoffee
          Layer.Simple##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `renderers <array of Renderers>` (inherited)
#### `scissor <array of numbers|null>` (inherited)




Properties
----------


