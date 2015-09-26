Renderer
========


#### The base class for all Renderer child-classes, like @todo which?

- Contains a program, a camera and an array of meshes
- A Renderer can be used by any number of Layers
- A Renderer can appear more than once in a layer’s `renderers` array
- All Renderers are stored in the `main._all` array, whether they’re used or not

@todo describe

    class Renderer
      C: 'Renderer'
      toString: -> "[object Renderer]"




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Renderer’s index in `main._all`
- `config <object>`  (optional) configuration and options

@todo describe

      constructor: (@main, @index, config={}) ->
        M = "/oo3d/src/renderer/base-renderer.litcoffee
          Renderer##{+@index}()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Renderer. 

        if ªO != typeof @main then throw TypeError "
          #{M}`main` is #{ªtype @main} not object"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` is '#{@main}' not '[object Oo3d]'"


#### `index <integer>`
This Renderer’s index in `main._all`. 

        if ªN != typeof @index then throw TypeError "
          #{M}`index` is #{ªtype @index} not number"
        if ªMAX < @index or @index % 1 or 0 > @index then throw RangeError "
          #{M}`index` is #{@index} not 0 or a positive integer below 2^53"


#### `program <Program>`
This Renderer’s Program, referenced from the main instance’s `_all` array. 

        if ªN != typeof config.programI then throw TypeError "
          #{M}config.programI is #{ªtype config.programI} not number"
        @program = @main._all[config.programI] or throw RangeError "
          #{M}No such index #{config.programI} in main._all"


#### `camera <Camera>`
This Renderer’s Camera, referenced from the main instance’s `cameras` array. 

        if ªN != typeof config.cameraI then throw TypeError "
          #{M}config.cameraI is #{ªtype config.cameraI} not number"
        @camera = @main._all[config.cameraI] or throw RangeError "
          #{M}No such index #{config.cameraI} in main._all"


#### `uMatCameraLoc <WebGLUniformLocation>`
Get the location of the 'uMatCamera' uniform in the Program’s vertex shader. 

        @uMatCameraLoc = @main.gl.getUniformLocation @program.program, 'uMatCamera'


#### `meshes <array of Item.Meshes>`
This Layer’s Renderers, referenced from the `main` instance’s `_all` array, in 
the order they will be rendered. 

        tMIs = ªtype config.meshIs
        if ªU == tMIs then @meshes = []
        else if ªA != tMIs then throw TypeError "
          #{M}`config.meshIs` is #{tMIs} not array"
        else @meshes = for index,i in config.meshIs
          if ªN != typeof index then throw TypeError "
            #{M}`config.meshIs[#{i}]` is #{ªtype index} not number"
          mesh = @main._all[index]
          if ! mesh or ! (mesh instanceof Item.Mesh) then throw TypeError "
            #{M}`config.meshIs[#{i}]` refs #{mesh.C} at `main._all[#{index}]`"
          mesh




BREAD API Methods
-----------------


#### `delete()`
- `targetI <integer>`   (optional) if set, the program, camera or mesh to delete
- `classParts <array>`  (required if `targetI` is set), eg `['Item','Mesh']`
- `<this>`             allows chaining

@todo describe  
@todo delete itself if `targetI` is undefined
@todo delete a program/camera or throw an exception if not recognised

      delete: (targetI, classParts) ->
        M = "/oo3d/src/renderer/base-renderer.litcoffee
          Renderer##{@index}:delete()\n  "

If `targetI` is an Item.Mesh, remove it from the `meshes` array without leaving 
any gaps, so that `meshes` can still be rapidly traversed during `render()`. 

        if 'Mesh' == classParts[1] # assume `'Item' == classParts[0]`
          i = @meshes.length
          while 0 <= --i
            if targetI == @meshes[i].index
              @meshes.splice i, 1
              return @ # found and deleted the mesh, so immediately stop
          return @ # some other mesh is being deleted

Prevent this renderer’s camera from being deleted. 

        if 'Camera' == classParts[1] # eg `['Item','Camera']`
          if @camera.index == targetI then throw RangeError "
            #{M}Cannot delete Camera##{targetI}` - used by Renderer##{@index}`"
          else return @ # some other camera is being deleted, so not an error

Prevent this renderer’s program from being deleted. 

        if 'Program' == classParts[0] # eg `['Program','Wireframe']`
          if @program.index == targetI then throw RangeError "
            #{M}Cannot delete Program##{targetI}` - used by Renderer##{@index}`"
          else return @ # some other program is being deleted, so not an error

        throw RangeError "
          #{M}`main._all[#{targetI}]` is '#{classParts.join '.'}' not 'Program|Item.Camera|Item.Mesh"




Other Methods
-------------


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
        uMeshColorLoc    = @program.uMeshColorLoc

        if ! gl then throw Error "The WebGL rendering context is #{ªtype gl}"

Switch to this Renderer’s Program. 

        gl.useProgram @program.program

Set the transform for this Renderer’s Camera. 

        gl.uniformMatrix4fv(
          @uMatCameraLoc,
          false,
          @camera.matCamera
        )

Xx. @todo move this to a less-repeated place

        if aVtxColorLoc
          gl.enableVertexAttribArray aVtxColorLoc

Step through each of this Renderer’s meshes, in reverse order. 

        index = @meshes.length
        while index--
          mesh = @meshes[index]
          if ! mesh then continue #@todo prevent gaps

Set the transform for this mesh. 

          gl.uniformMatrix4fv(
            uMatTransformLoc, # `location <WebGLUniformLocation>`
            gl.FALSE,         # `transpose` must be set to gl.FALSE @todo why?
            mesh.mT           # `value <Float32Array>` 
          )

Set the mesh color. 

          if uMeshColorLoc
            gl.uniform4fv(
              uMeshColorLoc,
              mesh.color
            )

Set each mesh’s Buffer.Position as the WebGLBuffer to be worked on. The 
previous binding is automatically broken. 

- `target <integer>`        specify what Buffer.Position contains: 
  - `ARRAY_BUFFER`          contains vertex attributes — use `drawArrays()`
  - `ELEMENT_ARRAY_BUFFER`  contains only indices — use `drawElements()`
- `buffer <WebGLBuffer>`    a WebGLBuffer object to bind to the target

          gl.bindBuffer gl.ARRAY_BUFFER, mesh.bP.glData


Specify the attribute-location and data-format for the newly bound mesh. 

- `index <WebGLUniformLocation>`  location of target attribute in the mesh
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
            gl.bindBuffer gl.ARRAY_BUFFER, mesh.bC.glData
            gl.vertexAttribPointer aVtxColorLoc, 4, gl.FLOAT, false, 0, 0

Apply the blend-mode, if any.  
@todo gather meshes with identical blend-modes, and draw them one after another

          if null != mesh.sBlend
            gl.enable gl.BLEND
            gl.blendFunc mesh.sBlend, mesh.dBlend
          else
            gl.disable gl.BLEND

Get the render mode. @todo scene override

          mode = gl[mesh.renderMode]

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

          gl.drawArrays mode, 0, mesh.count

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




    ;