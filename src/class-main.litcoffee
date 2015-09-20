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
      C: 'Oo3d'
      toString: -> "[object Oo3d]"


      constructor: (config={}) ->
        M = "/oo3d/src/class-main.litcoffee
          Oo3d()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"

Record all config as instance properties. 

        @[k] = v for k,v of config




Imported Libraries
------------------


#### `nwang <Nwang>`
Xx. @todo describe

        if ! Nwang then throw Error "
          #{M}Dependency 'Nwang' could not be found"
        @nwang = new Nwang




Instantiation Arguments
-----------------------


#### `$main <HTMLCanvasElement|null>`
The `<CANVAS>` element which will display the 3D scene. 

        @$main = config.$main or null
        if @$main and '[object HTMLCanvasElement]' != ''+@$main then throw TypeError "
          #{M}Optional `config.$main` is #{ªtype @$main} not HTMLCanvasElement"


#### `oT <string>`
The default order-of-transform for newly created Items.  
Defaults to 'trs', which transforms in the order translate > rotate > scale. 

        @oT = config.oT or 'trs'
        if ! {'trs':1,'rts':1,'srt':1}[@oT] then throw RangeError "
          #{M}Optional `config.oT` is not 'trs|rts|srt'"


#### `bkgndR, bkgndG, bkgndB and bkgndA <number 0-1>`
The canvas’s background clear-color. 

        if ! config.bkgnd
          @bkgndR = @bkgndG = @bkgndB = 0.25
          @bkgndA = 1
        else if 'float32array' == ªtype config.bkgnd
          if 4 != config.bkgnd.length then throw Error "
            #{M}If set `config.bkgnd` must contain four elements"
          @bkgndR = config.bkgnd[0] or 0 # `or 0` allows `NaN`
          @bkgndG = config.bkgnd[1] or 0
          @bkgndB = config.bkgnd[2] or 0
          @bkgndA = config.bkgnd[3] or 0
          if 0 > @bkgndR or @bkgndR > 1 then throw RangeError "
            #{M}`config.bkgnd[0]` (red) is not within range 0-1"
          if 0 > @bkgndG or @bkgndG > 1 then throw RangeError "
            #{M}`config.bkgnd[1]` (green) is not within range 0-1"
          if 0 > @bkgndB or @bkgndB > 1 then throw RangeError "
            #{M}`config.bkgnd[2]` (blue) is not within range 0-1"
          if 0 > @bkgndA or @bkgndA > 1 then throw RangeError "
            #{M}`config.bkgnd[3]` (alpha) is not within range 0-1"
        else
          throw TypeError "
          #{M}Optional `config.bkgnd` is #{ªtype config.bkgnd} not float32array"




Self-Assigned Properties
------------------------


#### `gl <WebGLRenderingContext|null>`
WebGL context, provided by the main `<CANVAS>` element’s `getContext()` method, 
after `initGL()` has been run. 

        @gl = null


#### `_all <array>`
Contains references to all the instances created by `main.add()`, below. Each 
element’s index is used as a unique identifier within the main Oo3d instance. 
When an app starts using Oo3d, `_all` will have a neat sequential set of 
indices. However, as instances are deleted, `_all` will have gaps. 

        @_all = []


#### `layers <array of Layers>`
An list of Layer instances in the order they will be rendered by main.render(). 

        @layers = []




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
        M = "#{@C}:initGL()\n  "
        try
          for ctx in ['webgl','experimental-webgl']
            @gl = @$main.getContext ctx, { preserveDrawingBuffer:true }
            if @gl then break
        catch
        if ! @gl then throw Error """
          #{M}Unable to initialize WebGL. Your browser may not support it."""
        #ª @gl.getSupportedExtensions()




#### `initCanvas()`
Set the canvas context background, and set various WebGL parameters.  
[From MDN’s first WebGL article, again.](https://goo.gl/DYPEVk)

1. Set clear-color to `config.bkgnd`, or else a dark opaque color
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
newly created items, if `config.positionI` and `config.colorI` are not set. 

      initBuffers: ->
        @add 'Buffer.Position', { data:[] } # an empty position `WebGLBuffer`
        @add 'Buffer.Color',    { data:[] } # an empty color `WebGLBuffer`




#### `cleanUp()`
Xx.  

      cleanUp: ->
        #@todo tell every Program (and other instances?) to `cleanUp()`




BREAD API Methods
-----------------


#### `browse()`
- `search <int|array|string>`  (optional) xx @todo describe
- `<array>`                    search results @todo describe

Xx. 

      browse: (search) ->
        M = "/oo3d/src/class-main.litcoffee
          Main:browse()\n  "
        return []




#### `read()`
- `target <int|array|string>`  xx @todo describe
- `format <string>`            (optional) one of 'object' (default), 'log' or 'nwang'
- `<object|string>`            xx @todo describe

Xx. 

      read: (target, format) ->
        M = "/oo3d/src/class-main.litcoffee
          Main:read()\n  "
        @_all[target].read format




#### `edit()`
- `target <int|array|null>`     xx @todo describe
- `set <object|string|null>`    edits which replace current properties
- `delta <object|string|null>`  (optional) edits which modify current properties
- <this>                        allows chaining

Xx. 

      edit: (target, set, delta) ->
        M = "/oo3d/src/class-main.litcoffee
          Main:edit()\n  "
        @_all[target].edit set, delta
        return @ # allows chaining




#### `add()`
- `className <string>`  capitalization matters, eg 'Item.Mesh' not 'item.mesh'
- `config <object>`     (optional) passed to the class contructor
- `<integer>`           index of the newly added instance in the `_all` array

Records a new instance in `_all`, and returns its index. 

      add: (className, config) ->
        M = "/oo3d/src/class-main.litcoffee
          Main:add()\n  "
        index = @_all.length

Make sure `className` is a string, and split it into two parts.  
@todo allow deeper nesting, eg 3 or 4 parts?

        if ªS != typeof className then throw TypeError "
          #{M}`className` is #{ªtype className} not string"
        parts = className.split '.'
        if 2 != parts.length then throw RangeError "
          #{M}`className` must be in 2 parts, not #{parts.length}"

Check that the class is recognized. 

        lut = #@todo move to a variable?
          'Buffer':   Buffer
          'Item':     Item
          'Layer':    Layer
          'Program':  Program
          'Renderer': Renderer
        base = lut[parts[0]]
        if ! base then throw RangeError "
          #{M}`className` base must be '#{(k for k of lut).join '|'}'"
        child = base[parts[1]]
        if ! child then throw RangeError "
          #{M}For `className` '#{parts[0]}' use '#{(k for k of base).join '|'}'"

Create the instance, and keep a reference to it in `_all`. For a Layer, also 
append a reference to the `main.layers` array, to be used by `main.render()`. 

        @_all[index] = new child @, index, config
        if 'Layer' == parts[0] then @layers.push @_all[index]

        return index




#### `delete()`
- `target <int|array|null>`  xx @todo describe
- `<this>`                   allows chaining

Xx. 

      delete: (target) ->
        M = "/oo3d/src/class-main.litcoffee
          Main:delete()\n  "
        ª "#{M}@todo"
        return @ # allows chaining




#### `rotate()`
- `x <number>`             radian angle about the x-axis
- `y <number>`             radian angle about the y-axis
- `z <number>`             radian angle about the z-axis
- `targetIndex <integer>`  (optional) a item-index, else target the camera

@todo describe  

      rotate: (x, y, z, targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @meshes[targetIndex] or @cameras[0]
        mat = target.mT

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

        target = @meshes[targetIndex] or @cameras[0]
        mat = target.mT

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

        target = @meshes[targetIndex] or @cameras[0]
        mat = target.mT

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

        target = @meshes[targetIndex] or @cameras[0]
        mat = target.mT

Reset the individual transform properties. 

        target.rX = target.rY = target.rZ = 0
        target.sX = target.sY = target.sZ = 1
        target.tX = target.tY = target.tZ = 0

Reset the transform matrix. 

        target.mT = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ])

For a camera transform, move to `Z = -4`, and update the `uMatCamera` uniform 
in the vertex-shader. 

        if target == @cameras[0]
          @cameras[0].tZ = -4
          @cameras[0].mT[14] = -4
          @cameras[0].updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `setRenderMode()`
- `mode <string>`          'POINTS', 'LINE_STRIP', 'TRIANGLES', etc
- `targetIndex <integer>`  (optional) a item-index, else target everything

Change the `mode` passed to `gl.drawArrays()` for an individual Shape, or the 
entire Scene. @todo scene

      setRenderMode: (renderMode, targetIndex) ->
        if ! @_all[targetIndex] then return #@todo prevent gaps
        @_all[targetIndex].renderMode = renderMode

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




#### `getMeshIByColor()`
- `color <Float32Array>`  xx @todo describe
- `<integer>`             index of the Item.Mesh instance in `main.meshes`

Get the index of the mesh in `meshes` which corresponds to `color`. 

      getMeshIByColor: (color) ->
        index = pick.colorToIndex color
        return index




#### `getCameraSnapshot()`
- `cameraI <integer>`  xx @todo describe
- `<object>`           xx @todo describe

Create an object which describes the given Camera’s current state.  
@todo not just the transform state

      getCameraSnapshot: (cameraI) ->
        camera = @cameras[cameraI]

Clone, don’t reference, `mT`. 

        mat = new Float32Array 16
        mat.set camera.mT

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




#### `getMeshSnapshot()`
- `meshI <integer>`  xx @todo describe
- `<object>`         xx @todo describe

Create an object which describes the given mesh’s current state.  
@todo also `item.dBlend` etc, not just the transform state

      getMeshSnapshot: (meshI) ->
        item = @meshes[meshI]

Clone, don’t reference, `mT`. 

        mat = new Float32Array 16
        mat.set item.mT

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

        camera.mT = new Float32Array 16
        camera.mT.set snapshot.mat

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




#### `setMeshSnapshot()`
- `snapshot <object>`  a snapshot of an Mesh, eg returned by `getMeshSnapshot()`
- `meshI <integer>`    the index, in `meshes`, of the target mesh

Replaces the given Mesh’s state with the properties in a snapshot object `s`. 
@todo also `item.dBlend` etc, not just the transform state  
@todo check that `snapshot.mat` is the outcome of the individual transforms?  
@todo check that all of the properties are valid?  

      setMeshSnapshot: (snapshot, meshI) ->
        item = @meshes[meshI]

Clone, don’t reference, `snapshot.mat`. 

        item.mT = new Float32Array 16
        item.mT.set snapshot.mat

Copy the remaining snapshot into the mesh’s state. 

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



