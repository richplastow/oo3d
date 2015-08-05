Scene
=====


#### Contains a selection of Shapes

    class Scene
      C: 'Scene'
      toString: -> "[object #{@C}]"

      constructor: (config={}, main) ->




Properties
----------


#### `main <Oo3d>`
Xx. @todo describe

        @main = main
        if 'object' != ªtype @main or 'oo3d' != ''+@main then throw Error """
          `main` must be Oo3d not #{ªtype @main}"""


#### `isActive <boolean>`
Whether the Scene should `render()`. 

        @isActive = config.isActive
        if ªU == ªtype @isActive then @isActive = true # default
        else if ªB != ªtype @isActive then throw Error """
          config.isActive must be boolean not #{ªtype @isActive}"""


#### `top, left, width, height <number 0-1>`
Where in the main canvas the Scene should be rendered. 

        @left   = config.left   or 0
        @top    = config.top    or 0
        @width  = config.width  or 1
        @height = config.height or 1


#### `renderers <array of Renderers>`
This Scene’s Renderers, referenced from the main instance’s `renderers` array. 

        #@renderers = (main.renderers[index] for index in config.rendererIndices)


#### `shapes <array of Shapes>`
This Scene’s Shapes, referenced from the main instance’s `shapes` array. 

        @shapes = (main.shapes[index] for index in config.shapeIndices)




Methods
-------


#### `renderz()`
Run each renderer. 

      renderz: ->

        renderer.render(@main, @shapes) for renderer in @renderers



#### `render()`
Draw each shape to the canvas, using the current program. 

      render: ->

For better performance, use local variables. 

        main             = @main
        $main            = main.$main
        gl               = main.gl
        aVtxPositionLoc  = main.aVtxPositionLoc
        aVtxColorLoc     = main.aVtxColorLoc
        uMatTransformLoc = main.uMatTransformLoc

        if ! gl then throw Error "The WebGL rendering context is #{ªtype gl}"

        gl.scissor(
          @left   * $main.width,
          @top    * $main.height,
          @width  * $main.width,
          @height * $main.height
        )

        #@todo switch to this Scene’s current program

        index = @shapes.length
        while index--

Set each shape’s `positionBuffer` as the WebGLBuffer to be worked on. The 
previous binding is automatically broken. 

- `target <integer>`        specify what `positionBuffer` contains: 
  - `ARRAY_BUFFER`          contains vertex attributes — use `drawArrays()`
  - `ELEMENT_ARRAY_BUFFER`  contains only indices — use `drawElements()`
- `buffer <WebGLBuffer>`    a WebGLBuffer object to bind to the target

          shape = @shapes[index]
          gl.bindBuffer gl.ARRAY_BUFFER, shape.positionBuffer


Specify the attribute-location and data-format for the newly bound shape. 

- `index <WebGLUniformLocation>`  location of target attribute in the shape
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


Repeat the two steps above, for the vertex-colors. 

          gl.bindBuffer gl.ARRAY_BUFFER, shape.colorBuffer
          gl.vertexAttribPointer aVtxColorLoc, 4, gl.FLOAT, false, 0, 0

Set the transform. 

          gl.uniformMatrix4fv(
            uMatTransformLoc,
            false,
            shape.matTransform
          )

Apply the blend-mode, if any.  
@todo gather shapes with identical blend-modes, and draw them one after another

          if null != shape.sBlend
            gl.enable gl.BLEND
            gl.blendFunc shape.sBlend, shape.dBlend
          else
            gl.disable gl.BLEND

Get the render mode. @todo scene override

          mode = gl[shape.renderMode]

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

          gl.drawArrays mode, 0, shape.count

@todo is this needed?

          gl.flush()

Prevent CoffeeScript converting the `while` loop into an array. 

        return




