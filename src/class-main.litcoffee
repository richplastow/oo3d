Main
====

@todo describe




Glossary
--------


#### Vertex attribute
Data such as vertex coordinates, texture coordinates, per-vertex colors, and 
normals. 


#### Vertex Buffer Object (VBO)
A memory buffer in the high speed memory of your video card, designed to hold 
vertex attributes. VBOs offer better performance than immediate-mode rendering, 
because the attributes are stored in video-card memory, not system memory. 


#### Vertex Array Object (VAO)
Contains one or more VBO. VAOs do not copy, freeze or store the contents of the 
referenced buffers - if you change any of the data in the buffers referenced by 
an existing VAO, those changes will be seen by all users of the VAO. 


#### Vertex Shader
A piece of C-like code which modifies a vertex’s attributes, such as position, 
color, and texture-coordinates. Run once for each vertex in the scene. 


#### Fragment Shader
This is where lighting and bump-mapping effects are performed. Run after all 
vertex shaders have completed, for each pixel in the canvas. 




Main Class
----------


#### The main class for Oo3d

    class Main
      C: "/src/class-main.litcoffee:#{ªC}"
      toString: -> "[object #{ªC}]"

      constructor: (config={}) ->
        M = "#{@C}:constructor()\n  "

Record all config as instance properties. 

        @[k] = v for k,v of config




Properties
----------


#### `nwang <Nwang>`
Xx. @todo describe

        if ! Nwang then throw Error "
          #{M}Dependency 'Nwang' could not be found"
        @nwang = new Nwang


#### `$main <HTMLCanvasElement|null>`
The `<CANVAS>` element which will display the 3D scene. 

        @$main = config.$main or null
        if @$main and ('htmlcanvaselement' != ªtype @$main) then throw Error """
          If set, config.$main must be HTMLCanvasElement not #{ªtype @$main}"""


#### `gl <WebGLRenderingContext|null>`
WebGL context, provided by the main `<CANVAS>` element’s `getContext()` method, 
after `initGL()` has been run. 

        @gl = null


#### `bkgndR, bkgndG, bkgndB and bkgndA <number 0-1>`
The canvas’s background clear-color. 

        if ªA == ªtype config.background
          @bkgndR = config.background[0]
          @bkgndG = config.background[1]
          @bkgndB = config.background[2]
          @bkgndA = config.background[3]
        else
          @bkgndR = @bkgndG = @bkgndB = 0.25
          @bkgndA = 1


#### `cameras <array of Cameras>`
Contains all Camera instances, whether or not any Renderers use them. 

        @cameras = []


#### `programs <array of Programs>`
Contains all Program instances, whether or not any Renderers use them. 

        @programs = []


#### `renderers <array of Renderers>`
Contains all Renderer instances, whether or not any Layers use them. 

        @renderers = []


#### `layers <array of Layers>`
An list of Layer instances in the order they will be rendered by main.render(). 

        @layers = []


#### `items <array of Items>`
Contains all current Item instances, whether or not any Renderers are using 
them. An Item can be present in any number of Renderers, or in none at all. In 
theory an Item could appear in a Renderer more than once, so that it renders on 
top of itself, which might make sense for some kinds of translucent effects. 

        @items = []


#### `positionBuffers and colorBuffers <array of WebGLBuffers>`
Contains all position and color buffers, whether or not any Items use them.

        @positionBuffers = []
        @colorBuffers    = []




Init
----


Initialize the instance, if `@$main` has been defined. 

        if @$main
          @initGL()
          if @gl
            @initCanvas()
            @initBuffers()




Init Methods
------------


#### `initGL()`
Try to grab the standard WebGL context. If it fails, fallback to experimental. 
If that fails, show an error alert. [From MDN’s article.](https://goo.gl/DYPEVk)

Note that despite a possible performance penalty, `preserveDrawingBuffer` is 
required for `readPixels()` in `getColorAt()` to work. 

      initGL: ->
        try
          for ctx in ['webgl','experimental-webgl']
            ª ctx
            @gl = @$main.getContext ctx, { preserveDrawingBuffer:true }
            if @gl then break
        catch
        if ! @gl then throw Error """
          Unable to initialize WebGL. Your browser may not support it."""
        #ª @gl.getSupportedExtensions()




#### `initCanvas()`
Set the canvas context background, and set various WebGL parameters.  
[From MDN’s first WebGL article, again.](https://goo.gl/DYPEVk)  
1. Set clear-color to `config.color.background`, or else opaque black  
2. [Enable depth testing](https://goo.gl/Eirl49)  
3. [Near things obscure far things](https://goo.gl/4v3dAl)  
4. Clear the color as well as the depth buffer  
5. Set the viewport to the canvas width and height

      initCanvas: ->
        @gl.clearColor @bkgndR, @bkgndG, @bkgndB, @bkgndA
        @gl.enable @gl.DEPTH_TEST
        @gl.enable @gl.SCISSOR_TEST
        @gl.depthFunc @gl.LEQUAL # less-than-or-equal (default is gl.LESS)
        @gl.scissor 0, 0, @$main.width, @$main.height
        @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT
        #@gl.viewport 0, 0, @$main.width, @$main.height @todo is this needed?

@todo fix 'Error: WebGL: enable: invalid enum value <enum 0x8642>'

        @gl.enable @gl.VERTEX_PROGRAM_POINT_SIZE
        #@gl.enable @gl.POINT_SMOOTH #@todo why not working?
        #@gl.enable @gl.BLEND
        #@gl.blendFunc @gl.ONE, @gl.ONE
        #@gl.blendColor 0.2, 0.7, 0.1, 0.4
        #gl.blendEquationSeparate gl.FUNC_REVERSE_SUBTRACT, gl.FUNC_SUBTRACT
        #gl.depthMask true
        #gl.disable gl.DEPTH_TEST




#### `initBuffers()`
Guarantees that position and color buffers exist at index 0. These are used by 
newly created Items, if `config.positionI` and `config.colorI` are not set. 

      initBuffers: ->
        @addPositionBuffer []
        @addColorBuffer []




#### `cleanUp()`
Xx.  

      cleanUp: ->
        #@todo tell every Program (and other objects?) to clearUp()




API Methods
-----------


#### `addItem()`
- `config.renderMode <string>`  (optional) 'POINTS', 'TRIANGLES', etc
- `config.blend <array>`        (optional) eg `['ONE','DST_COLOR']`
- `config.positionI <integer>`  index in `positionBuffers`
- `config.colorI <integer>`     (optional) index in `colorBuffers`
- `<integer>`                   index of the newly added item in `items`

Records a new `Item` instance in `items` and returns its index. 
If `config.colors` is not set, all vertices are set to 100% opacity white.  
[From MDN’s second WebGL article.](https://goo.gl/q6YFNe)  

      addItem: (config) ->
        index = @items.length
        @items[index] = new Item @, index, config
        return index




#### `addCamera()`
- `config <object>`  passed to the `Camera` contructor
- `<integer>`        index of the newly added Camera in `@cameras`

Records a new `Camera` instance in `cameras` and returns its index. 

      addCamera: (config) ->
        index = @cameras.length
        @cameras[index] = new Camera @, config
        ª index
        return index




#### `addProgram()`
- `config <object>`  passed to the `Program` contructor
- `<integer>`        index of the newly added Program in `@programs`

Records a new `Program` instance in `programs` and returns its index. 

      addProgram: (config) ->

        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"
        if ªS != ªtype config.subclass then throw TypeError "
          `config.subclass` must be string not #{ªtype config.subclass}"
        if ! Program[config.subclass] then throw RangeError "
          `Program.#{config.subclass}` does not exist"

        index = @programs.length
        @programs[index] = new Program[config.subclass] @, config
        return index




#### `addRenderer()`
- `config <object>`  passed to the `Renderer` contructor
- `<integer>`        index of the newly added Renderer in `@renderers`

Records a new `Renderer` instance in `renderers` and returns its index. 

      addRenderer: (config) ->
        index = @renderers.length
        @renderers[index] = new Renderer @, config
        return index




#### `addLayer()`
- `config <object>`  passed to the `Layer` contructor
- `<integer>`        index of the newly added Layer in `@layers`

Records a new `Layer` instance in `layers` and returns its index. 

      addLayer: (config) ->
        index = @layers.length
        @layers[index] = new Layer @, config
        return index




#### `addPositionBuffer()`
- `positions <array of floats>`  xx @todo describe
- `<integer>`                    new WebGLBuffer’s index in `@positionBuffers`

Records a new `WebGLBuffer` instance in `positionBuffers` and returns its index.

      addPositionBuffer: (positions) ->
        index = @positionBuffers.length
        if ªA != ªtype positions then throw Error """
          `positions` must be an array not #{ªtype positions}"""
        else if positions.length % 3 then throw Error """
          `positions.length` must be divisible by 3"""
        @positionBuffers[index] = @gl.createBuffer()
        @positionBuffers[index].count = positions.length / 3
        @gl.bindBuffer @gl.ARRAY_BUFFER, @positionBuffers[index]
        @gl.bufferData(
          @gl.ARRAY_BUFFER,
          new Float32Array(positions), @gl.STATIC_DRAW
        )
        return index




#### `addColorBuffer()`
- `colors <array of floats>`  xx @todo describe
- `<integer>`                 new WebGLBuffer’s index in `@colorBuffers`

Records a new `WebGLBuffer` instance in `colorBuffers` and returns its index. 

      addColorBuffer: (colors) ->
        index = @colorBuffers.length
        if ªA != ªtype colors then throw Error """
          `colors` must be an array not #{ªtype colors}"""
        else if colors.length % 4 then throw Error """
          `colors.length` must be divisible by 4"""
        @colorBuffers[index] = @gl.createBuffer()
        @colorBuffers[index].count = colors.length / 4
        @gl.bindBuffer @gl.ARRAY_BUFFER, @colorBuffers[index]
        @gl.bufferData(
          @gl.ARRAY_BUFFER,
          new Float32Array(colors), @gl.STATIC_DRAW
        )
        return index




#### `rotate()`
- `x <number>`             radian angle about the x-axis
- `y <number>`             radian angle about the y-axis
- `z <number>`             radian angle about the z-axis
- `targetIndex <integer>`  (optional) a item-index, else target the camera

@todo describe  

      rotate: (x, y, z, targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @items[targetIndex] or @cameras[0]
        mat = target.matTransform

Determine which axes are zero, if any. 

        x0 = 0 == x
        y0 = 0 == y
        z0 = 0 == z

Deal with a noop. 

        if x0 and y0 and z0
          return @ # allows chaining

Rotate about the X-axis. 

        else if y0 and z0
          s = Math.sin x
          c = Math.cos x
          m10 = mat[4] ; m11 = mat[5] ; m12 = mat[6] ; m13 = mat[7]
          m20 = mat[8] ; m21 = mat[9] ; m22 = mat[10]; m23 = mat[11]
          mat[4]  = m10 * c + m20 * s
          mat[5]  = m11 * c + m21 * s
          mat[6]  = m12 * c + m22 * s
          mat[7]  = m13 * c + m23 * s
          mat[8]  = m20 * c - m10 * s
          mat[9]  = m21 * c - m11 * s
          mat[10] = m22 * c - m12 * s
          mat[11] = m23 * c - m13 * s
          target.rX += x

Rotate about the Y-axis. 

        else if x0 and z0
          s = Math.sin y
          c = Math.cos y
          m00 = mat[0] ; m01 = mat[1] ; m02 = mat[2] ; m03 = mat[3]
          m20 = mat[8] ; m21 = mat[9] ; m22 = mat[10]; m23 = mat[11]
          mat[0]  = m00 * c - m20 * s
          mat[1]  = m01 * c - m21 * s
          mat[2]  = m02 * c - m22 * s
          mat[3]  = m03 * c - m23 * s
          mat[8]  = m00 * s + m20 * c
          mat[9]  = m01 * s + m21 * c
          mat[10] = m02 * s + m22 * c
          mat[11] = m03 * s + m23 * c
          target.rY += y

Rotate about the Z-axis. 

        else if x0 and y0
          s = Math.sin z
          c = Math.cos z
          m00 = mat[0] ; m01 = mat[1] ; m02 = mat[2] ; m03 = mat[3]
          m10 = mat[4] ; m11 = mat[5] ; m12 = mat[6] ; m13 = mat[7]
          mat[0] = m00 * c + m10 * s
          mat[1] = m01 * c + m11 * s
          mat[2] = m02 * c + m12 * s
          mat[3] = m03 * c + m13 * s
          mat[4] = m10 * c - m00 * s
          mat[5] = m11 * c - m01 * s
          mat[6] = m12 * c - m02 * s
          mat[7] = m13 * c - m03 * s
          target.rZ += z

Otherwise, two or three axes are non-zero, so recursively call this method.  
@todo find a single calculation to do this. 

        else
          @rotate x, 0, 0, targetIndex
          @rotate 0, y, 0, targetIndex
          @rotate 0, 0, z, targetIndex

For a camera transform, update the `uMatCamera` uniform in the vertex-shader. 

        if target == @cameras[0] then @cameras[0].updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `scale()`
- `x <number>`             scale-factor along the x-axis
- `y <number>`             scale-factor along the y-axis
- `z <number>`             scale-factor along the z-axis
- `targetIndex <integer>`  (optional) a item-index, else target the camera

@todo describe  
@todo make objects rotate as expected when non-uniform scale is applied  
@todo reversing a non-uniform scale should be possible after rotating

      scale: (x, y, z, targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @items[targetIndex] or @cameras[0]
        mat = target.matTransform

Determine which axes are set to `1`, if any. 

        x1 = 1 == x
        y1 = 1 == y
        z1 = 1 == z

Scale along the X-axis. 

        if ! x1
          mat[0]  *= x
          mat[1]  *= x
          mat[2]  *= x
          mat[3]  *= x #@todo needed?
          target.sX *= x

Scale along the Y-axis. 

        if ! y1
          mat[4]  *= y
          mat[5]  *= y
          mat[6]  *= y
          mat[7]  *= y #@todo needed?
          target.sY *= y

Scale along the Z-axis. 

        if ! z1
          mat[8]  *= z
          mat[9]  *= z
          mat[10] *= z
          mat[11] *= z #@todo needed?
          target.sZ *= z

For a camera transform, update the `uMatCamera` uniform in the vertex-shader. 

        if target == @cameras[0] then @cameras[0].updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `translate()`
- `x <number>`             distance along the x-axis
- `y <number>`             distance along the y-axis
- `z <number>`             distance along the z-axis
- `targetIndex <integer>`  (optional) a item-index, else target the camera

@todo describe  

      translate: (x, y, z, targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @items[targetIndex] or @cameras[0]
        mat = target.matTransform

Determine which axes are zero, if any. 

        x0 = 0 == x
        y0 = 0 == y
        z0 = 0 == z

Deal with a noop. 

        if x0 and y0 and z0
          return @ # allows chaining

Translate in the X-axis. 

        else if y0 and z0
          mat[12] += mat[0] * x
          mat[13] += mat[1] * x
          mat[14] += mat[2] * x
          mat[15] += mat[3] * x
          target.tX += x

Translate in the Y-axis. 

        else if x0 and z0
          mat[12] += mat[4] * y
          mat[13] += mat[5] * y
          mat[14] += mat[6] * y
          mat[15] += mat[7] * y
          target.tY += y

Translate in the Z-axis. 

        else if x0 and y0
          mat[12] += mat[8]  * z
          mat[13] += mat[9]  * z
          mat[14] += mat[10] * z
          mat[15] += mat[11] * z
          target.tZ += z

Otherwise, two or three axes are non-zero, so run the more complex calculation. 

        else
          mat[12] += mat[0] * x + mat[4] * y + mat[8]  * z
          mat[13] += mat[1] * x + mat[5] * y + mat[9]  * z
          mat[14] += mat[2] * x + mat[6] * y + mat[10] * z
          mat[15] += mat[3] * x + mat[7] * y + mat[11] * z
          target.tX += x
          target.tY += y
          target.tZ += z

For a camera transform, update the `uMatCamera` uniform in the vertex-shader. 

        if target == @cameras[0] then @cameras[0].updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `resetTransform()`
- `targetIndex <integer>`  (optional) a item-index, else target the camera

@todo describe  

      resetTransform: (targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @items[targetIndex] or @cameras[0]
        mat = target.matTransform

Reset the individual transform properties. 

        target.rX = target.rY = target.rZ = 0
        target.sX = target.sY = target.sZ = 1
        target.tX = target.tY = target.tZ = 0

Reset the transform matrix. 

        target.matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])

For a camera transform, move to `Z = -4`, and update the `uMatCamera` uniform 
in the vertex-shader. 

        if target == @cameras[0]
          @cameras[0].tZ = -4
          @cameras[0].matTransform[14] = -4
          @cameras[0].updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `setRenderMode()`
- `mode <string>`          'POINTS', 'LINE_STRIP', 'TRIANGLES', etc
- `targetIndex <integer>`  (optional) a item-index, else target everything

Change the `mode` passed to `gl.drawArrays()` for an individual Shape, or the 
entire Scene. @todo scene

      setRenderMode: (renderMode, targetIndex) ->
        if ! @items[targetIndex] then return #@todo prevent gaps
        @items[targetIndex].renderMode = renderMode

Return this Oo3d instance (allows chaining). 

        return @




#### `getColorAt()`
- `x <number>`             position on the x-axis
- `y <number>`             position on the y-axis
- `<Float32Array>`         xx @todo describe

Get the color value at the given coordinates.  
[`readPixels()` specs](https://goo.gl/duAvjk)

      getColorAt: (x, y) ->
        pixels = new Uint8Array 4
        @gl.readPixels(      # read a block of pixels from the frame buffer
          x,                 # `x <number>`
          y,                 # `y <number>`
          1,                 # `width <number>`
          1,                 # `height <number>`
          @gl.RGBA,          # `format` “only `gl.RGBA` is supported” @todo why?
          @gl.UNSIGNED_BYTE, # `type <number>`
          pixels             # `pixels <Uint8Array>`
        )
        return pixels




#### `getItemIByColor()`
- `color <Float32Array>`  xx @todo describe
- `<integer>`             index of the Item in `main.items`

Get the index of the Item in `items` which corresponds to `color`. 

      getItemIByColor: (color) -> pick.colorToIndex color




#### `getCameraSnapshot()`
- `cameraI <integer>`  xx @todo describe
- `<object>`           xx @todo describe

Create an object which describes the given Camera’s current state.  
@todo not just the transform state

      getCameraSnapshot: (cameraI) ->
        camera = @cameras[cameraI]

Clone, don’t reference, `matTransform`. 

        mat = new Float32Array 16
        mat.set camera.matTransform

Return the snapshot. 

        mat: mat
        rX:  camera.rX
        rY:  camera.rY
        rZ:  camera.rZ
        sX:  camera.sX
        sY:  camera.sY
        sZ:  camera.sZ
        tX:  camera.tX
        tY:  camera.tY
        tZ:  camera.tZ




#### `getItemSnapshot()`
- `itemI <integer>`  xx @todo describe
- `<object>`         xx @todo describe

Create an object which describes the given Item’s current state.  
@todo also `item.dBlend` etc, not just the transform state

      getItemSnapshot: (itemI) ->
        item = @items[itemI]

Clone, don’t reference, `matTransform`. 

        mat = new Float32Array 16
        mat.set item.matTransform

Return the snapshot. 

        mat: mat
        rX:  item.rX
        rY:  item.rY
        rZ:  item.rZ
        sX:  item.sX
        sY:  item.sY
        sZ:  item.sZ
        tX:  item.tX
        tY:  item.tY
        tZ:  item.tZ




#### `setCameraSnapshot()`
- `snapshot <object>`  a snapshot of an Camera, eg returned by `getCameraSnapshot()`
- `cameraI <integer>`  the index, in `cameras`, of the target Camera

Replaces the given Camera’s state with the properties in a snapshot object `s`. 
@todo not just the transform state  
@todo check that `snapshot.mat` is the outcome of the individual transforms?  
@todo check that all of the properties are valid?  

      setCameraSnapshot: (snapshot, cameraI) ->
        camera = @cameras[cameraI]

Clone, don’t reference, `snapshot.mat`. 

        camera.matTransform = new Float32Array 16
        camera.matTransform.set snapshot.mat

Copy the remaining snapshot into the Camera’s state. 

        camera.rX = snapshot.rX
        camera.rY = snapshot.rY
        camera.rZ = snapshot.rZ
        camera.sX = snapshot.sX
        camera.sY = snapshot.sY
        camera.sZ = snapshot.sZ
        camera.tX = snapshot.tX
        camera.tY = snapshot.tY
        camera.tZ = snapshot.tZ

Return this Oo3d instance (allows chaining). 

        return @




#### `setItemSnapshot()`
- `snapshot <object>`  a snapshot of an Item, eg returned by `getItemSnapshot()`
- `itemI <integer>`    the index, in `items`, of the target Item

Replaces the given Item’s state with the properties in a snapshot object `s`. 
@todo also `item.dBlend` etc, not just the transform state  
@todo check that `snapshot.mat` is the outcome of the individual transforms?  
@todo check that all of the properties are valid?  

      setItemSnapshot: (snapshot, itemI) ->
        item = @items[itemI]

Clone, don’t reference, `snapshot.mat`. 

        item.matTransform = new Float32Array 16
        item.matTransform.set snapshot.mat

Copy the remaining snapshot into the Item’s state. 

        item.rX = snapshot.rX
        item.rY = snapshot.rY
        item.rZ = snapshot.rZ
        item.sX = snapshot.sX
        item.sY = snapshot.sY
        item.sZ = snapshot.sZ
        item.tX = snapshot.tX
        item.tY = snapshot.tY
        item.tZ = snapshot.tZ

Return this Oo3d instance (allows chaining). 

        return @




#### `render()`
Draw each layer to the canvas. 

      render: ->
        if ! @gl then throw Error "The WebGL rendering context is #{ªtype @gl}"

        @gl.clearColor @bkgndR, @bkgndG, @bkgndB, @bkgndA
        @gl.scissor 0, 0, @$main.width, @$main.height
        @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT

        layer.render() for layer in @layers

Return this Oo3d instance (allows chaining). 

        return @



