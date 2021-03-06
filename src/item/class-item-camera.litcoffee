Item.Camera
===========


@todo describe

    class Item.Camera extends Item
      C: 'Item.Camera'
      toString: -> '[object Item.Camera]'




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Item.Camera’s index in `main._all`
- `config <object>`  (optional) configuration and options

@todo describe

      constructor: (main, index, config={}) ->
        M = "/oo3d/src/item/class-item-camera.litcoffee
          Item.Camera##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `oT <string>` (inherited)
#### `mT <Float32Array>` (inherited)
#### `rX, rY, rZ <number>` (inherited)
#### `sX, sY, sZ <number>` (inherited)
#### `tX, tY, tZ <number>` (inherited)




Instantiation Arguments
-----------------------




#### `fovy <number>`
@todo describe

        @fovy = config.fovy
        if ªU == ªtype @fovy
          @fovy = 0.785398163 # 45º
        else if ªN != ªtype @fovy then throw TypeError "
          #{M}Optional `config.fovy` is #{ªtype @fovy} not number"
        else if 0 >= @fovy then throw RangeError "
          #{M}Optional `config.fovy` is #{@fovy} not greater than zero"


#### `aspect <number>`
@todo describe

        @aspect = config.aspect
        if ªU == ªtype @aspect
          @aspect = @main.$main.width / @main.$main.height
        else if ªN != ªtype @aspect then throw TypeError "
          #{M}Optional `config.aspect` is #{ªtype @aspect} not number"
        else if 0 >= @aspect then throw RangeError "
          #{M}Optional `config.aspect` is #{@aspect} not greater than zero"




Self-Assigned Properties
------------------------


#### `matProjection <array|null>`
The projection-matrix currently applied to this camera. 

        @matProjection = mat4.perspective(
          @fovy,
          @aspect,
          1,   # near
          100  # far
        )


#### `matCamera <array|null>`
Result of the camera-projection multiplied by the camera-transformation. 
Its initial value is calculated by calling `updateCamera()`. 

        @matCamera = null


#### `mT <array> and tZ <number>`
Modify the inherited position so that the camera starts at (0,0,-4). 

        @mT[14] = -4
        @tZ     = -4




Init
----


        @updateCamera()




Methods
-------


#### `updateCamera()`
Calculate the camera-matrix, and update the 'uMatCamera' uniform. @todo remove commented block, as moved elsewhere

      updateCamera: ->
        @matCamera = new Float32Array mat4.multiply @matProjection, @mT
        #@main.gl.uniformMatrix4fv(
        #  @uMatCameraLoc,
        #  false,
        #  new Float32Array @matCamera
        #)




#### `reset()`
- `subject <object>`  xx @todo describe
- `<object>`          the reset object

Resets properties on the given object.  
Used by `Item:edit('reset')`. 

      reset: (subject) ->
        M = "/oo3d/src/item/class-item-camera.litcoffee
          Item.Camera##{@index}:reset()\n  "
        super subject
        subject.mT[14] = -4
        subject.tZ     = -4
        subject




