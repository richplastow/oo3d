Renderer
========


#### The base class for all Renderers

- Contains a Program, a Camera and an array of Items
- Each Layer has an array of Renderers
- A Renderer can be used by any number of Layers
- All Renderers are stored in the main.renderers array

    class Renderer
      C: 'Renderer'
      toString: -> "[object #{@C}]"

      constructor: (@main, config={}) ->
        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Renderer. 

        if ªO != ªtype @main then throw TypeError "
          `main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          `main` must be [object Oo3d] not #{@main}"


#### `program <Program>`
This Renderer’s Program, referenced from the main instance’s `programs` array. 

        if ªN != ªtype config.programI then throw TypeError "
          config.programI must be number not #{ªtype config.programI}"
        @program = @main.programs[config.programI] or throw RangeError "
          No such index #{config.programI} in main.programs"


#### `camera <Camera>`
This Renderer’s Camera, referenced from the main instance’s `cameras` array. 

        if ªN != ªtype config.cameraI then throw TypeError "
          config.cameraI must be number not #{ªtype config.cameraI}"
        @camera = @main.cameras[config.cameraI] or throw RangeError "
          No such index #{config.cameraI} in main.cameras"


#### `uMatCameraLoc <WebGLUniformLocation>`
Get the location of the 'uMatCamera' uniform in the Program’s vertex shader. 

        @uMatCameraLoc = @main.gl.getUniformLocation @program.program, 'uMatCamera'


#### `items <array of Items>`
This Renderer’s Items, referenced from the main instance’s `items` array. 

        if ! config.itemIs then @items = []
        else if 'uint16array' != ªtype config.itemIs then throw TypeError "
          If set, config.itemIs must be Uint16Array not #{ªtype config.itemIs}"
        else @items = (@main.items[i] or throw RangeError "
          No such index #{i} in main.items" for i in config.itemIs)




Methods
-------


#### `render()`
Xx. @todo describe

      render: ->

For better performance, use local variables. 

        main             = @main
        $main            = main.$main
        gl               = main.gl
        aVtxPositionLoc  = @program.aVtxPositionLoc
        aVtxColorLoc     = @program.aVtxColorLoc or false # some Programs, only
        uMatTransformLoc = @program.uMatTransformLoc

        if ! gl then throw Error "The WebGL rendering context is #{ªtype gl}"

Switch to this Renderer’s Program. 

        gl.useProgram @program.program

Set the transform for this Renderer’s Camera. 

        gl.uniformMatrix4fv(
          @uMatCameraLoc,
          false,
          @camera.matCamera
        )

Before the loop, the previous Renderer’s Program may not have used `aVtxColor`. 

        if aVtxColorLoc
          gl.enableVertexAttribArray aVtxColorLoc

Step through each of this Renderer’s Items, in reverse order. 

        index = @items.length
        while index--
          item = @items[index]

Set the transform for this Item. 

          gl.uniformMatrix4fv(
            uMatTransformLoc,
            false,
            item.matTransform
          )


Set each Item’s `positionBuffer` as the WebGLBuffer to be worked on. The 
previous binding is automatically broken. 

- `target <integer>`        specify what `positionBuffer` contains: 
  - `ARRAY_BUFFER`          contains vertex attributes — use `drawArrays()`
  - `ELEMENT_ARRAY_BUFFER`  contains only indices — use `drawElements()`
- `buffer <WebGLBuffer>`    a WebGLBuffer object to bind to the target

          gl.bindBuffer gl.ARRAY_BUFFER, item.positionBuffer


Specify the attribute-location and data-format for the newly bound item. 

- `index <WebGLUniformLocation>`  location of target attribute in the item
- `size <integer>`        components per attribute: 1, 2, 3 or (default) 4
- `type <integer>`        the data type of each component in the array: 
  * `BYTE`                  signed 8-bit two’s complement value, -128 to +127
  * `FIXED`                 16-bit fixed-point two’s complement value
  * `FLOAT` (default)       32-bit single-precision floating-point value
  * `SHORT`                 signed 16-bit two’s complement value
  * `UNSIGNED_BYTE`         unsigned 8-bit value
  * `UNSIGNED_SHORT`        unsigned 16-bit value
- `normalized <boolean>`  Must be `FALSE` if `type` is `FIXED` or `FLOAT`
  * `TRUE`                  integers represent [-1,1] if signed, [0,1] if not
  * `FALSE`                 values are converted to fixed-point when accessed
- `stride <integer>`      default is 0, max is 255, must be multiple of `type`, 
                          defines the byte offset between consecutive attributes
- `pointer <integer>`     default is 0, must be multiple of `type`, defines the 
                          first component’s first attribute’s offset

          gl.vertexAttribPointer aVtxPositionLoc, 3, gl.FLOAT, false, 0, 0


Repeat the two steps above for the vertex-colors, if the Program supports it. 

          if aVtxColorLoc
            gl.bindBuffer gl.ARRAY_BUFFER, item.colorBuffer
            gl.vertexAttribPointer aVtxColorLoc, 4, gl.FLOAT, false, 0, 0

Apply the blend-mode, if any.  
@todo gather Items with identical blend-modes, and draw them one after another

          if null != item.sBlend
            gl.enable gl.BLEND
            gl.blendFunc item.sBlend, item.dBlend
          else
            gl.disable gl.BLEND

Get the render mode. @todo scene override

          mode = gl[item.renderMode]

Render geometric primitives, using the currently bound vertex data. 

- `mode <integer>`   the kind of geometric primitives to render:
  * `POINTS`           a single dot per vertex, so 10 vertices draws 10 dots
  * `LINES`            lines between vertex pairs, 10 vertices draws 5 lines
  * `LINE_STRIP`       join all vertices using lines, 10 vertices draws 9 lines
  * `LINE_LOOP`        as LINE_STRIP but connects last vertex back to the first
  * `TRIANGLES`        a triangle for each set of three consecutive vertices
  * `TRIANGLE_STRIP`   vertex 4 adds a new triangle after the 1st has been drawn
  * `TRIANGLE_FAN`     like TRIANGLE_STRIP, but creates a fan shaped output
- `first <integer>`  the first element to render in the array of vector points
- `count <integer>`  the number of vector points to render, eg 3 for a triangle
- `<undefined>`      does not return anything

          gl.drawArrays mode, 0, item.count

@todo is this needed?

          gl.flush()

After the loop, the next Renderer’s Program may not use `aVtxColor`. 
@todo is this needed?

        if aVtxColorLoc
          gl.disableVertexAttribArray aVtxColorLoc




Classes
-------


#### 
Xx. @todo describe

      class RendererTypeError extends TypeError
        constructor: (message) ->
          @message = "Renderer #{message}"
          @name = @constructor.name
        @:: = new Error() # or `@:: = Error()` may work just as well
        @::constructor = @




