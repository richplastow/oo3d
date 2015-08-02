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
      C: ªC
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->

Record all config as instance properties. 

        @[k] = v for k,v of config




Properties
----------


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
Used by `initCanvas()` to set the canvas clear-color. 

        if ªO == ªtype config.color?.background
          @bkgndR = config.color.background.r
          @bkgndG = config.color.background.g
          @bkgndB = config.color.background.b
          @bkgndA = config.color.background.a
        else
          @bkgndR = @bkgndG = @bkgndB = 0.125
          @bkgndA = 1

#### `vertexShader and fragmentShader <WebGLShader|null>`
Xx. 

        @vertexShader   = null
        @fragmentShader = null


#### `program <WebGLProgram|null>`
Xx. 

        @program = null


#### `aVtxPositionLoc and aVtxColorLoc <WebGLUniformLocation|null>`
Locations of the `aVtxPosition` and `aVtxColor` attributes in the Vertex Shader.

        @aVtxPositionLoc = null
        @aVtxColorLoc    = null


#### `buffer <array of Buffers>`
Contains all current Buffer instances. 

        @buffers = []




Init
----


Initialize the instance, if `@$main` has been defined. 

        if @$main
          @initGL()
          if @gl
            @initCanvas()
            @initShaders()
            @initProgram()
            @camera = new Camera @, # scene
              fovy: 0.785398163 # 45º
              aspect: @$main.width / @$main.height



Init Methods
------------


#### `initGL()`
Try to grab the standard WebGL context. If it fails, fallback to experimental. 
If that fails, show an error alert. [From MDN’s article.](https://goo.gl/DYPEVk)

      initGL: ->
        try
          @gl =
            @$main.getContext 'webgl' or @$main.getContext 'experimental-webgl'
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
        @gl.depthFunc @gl.LEQUAL
        @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT
        @gl.viewport 0, 0, @$main.width, @$main.height #@todo is this necessary?



#### `initShaders()`
Create the two types of shader. Compile them from source code defined below.  
[From MDN’s second WebGL article.](https://goo.gl/q6YFNe)  

      initShaders: ->
        @vertexShader   = @gl.createShader @gl.VERTEX_SHADER
        @fragmentShader = @gl.createShader @gl.FRAGMENT_SHADER
        @gl.shaderSource @vertexShader  , getVertexSource()
        @gl.shaderSource @fragmentShader, getFragmentSource()
        @gl.compileShader @vertexShader
        @gl.compileShader @fragmentShader

Check that they compiled successfully. 

        if ! @gl.getShaderParameter @vertexShader,   @gl.COMPILE_STATUS
          @cleanUp(); throw Error "@vertexShader did not compile successfully"
        if ! @gl.getShaderParameter @fragmentShader, @gl.COMPILE_STATUS
          @cleanUp(); throw Error "@fragmentShader did not compile successfully"




#### `initProgram()`
Xx.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      initProgram: ->
        @program = @gl.createProgram()
        @gl.attachShader @program, @vertexShader
        @gl.attachShader @program, @fragmentShader
        @gl.linkProgram @program

Check that it linked successfully. 

        if ! @gl.getProgramParameter @program, @gl.LINK_STATUS
          @cleanUp(); throw Error "@program did not link successfully"

Xx. 

        @gl.useProgram @program

Get the index of the vertex-position and vertex-color attributes in the shader 
program we just created. The index allows us to switch on these attributes, and 
bind the buffers’ position and color data to `aVtxPosition` and `aVtxColor`. 

        @aVtxPositionLoc = @gl.getAttribLocation @program, 'aVtxPosition'
        @aVtxColorLoc = @gl.getAttribLocation @program, 'aVtxColor'

Enable the vertex-position and -color attributes. `enableVertexAttribArray()` 
takes the index of the vertex attribute which should be enabled. 

        @gl.enableVertexAttribArray @aVtxPositionLoc
        @gl.enableVertexAttribArray @aVtxColorLoc

Get the location of the 'uMatTransform' vertex shader uniform. 

        @uMatTransformLoc = @gl.getUniformLocation @program, 'uMatTransform' 




#### `cleanUp()`
Xx.  

      cleanUp: ->
        if @vertexShader   then @gl.deleteShader @vertexShader
        if @fragmentShader then @gl.deleteShader @fragmentShader
        if @program        then @gl.deleteProgram @program




API Methods
-----------


#### `addBuffer()`
- `config.positions <array>`  x, y, and z coordinates
- `config.colors <array>`     (optional) r, g, b, and alpha (each [0,1])
- `<integer>`                 index of the newly added buffer in `@buffers`

If `config.colors` is not set, all vertices are set to 100% opacity white.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      addBuffer: (config) ->

Record a new instance of the `Buffer` class in `buffers`, and get its index. 

        index = @buffers.length
        @buffers[index] = new Buffer config, @gl

Return the index of the newly added buffer in `@buffers`. 

        index




#### `rotate()`
- `x <number>`             radian angle about the x-axis
- `y <number>`             radian angle about the y-axis
- `z <number>`             radian angle about the z-axis
- `targetIndex <integer>`  (optional) a buffer-index, else target the camera

@todo describe  

      rotate: (x, y, z, targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @buffers[targetIndex] or @camera
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

        if target == @camera then @camera.updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `scale()`
- `x <number>`             scale-factor in the x-axis
- `y <number>`             scale-factor in the y-axis
- `z <number>`             scale-factor in the z-axis
- `targetIndex <integer>`  (optional) a buffer-index, else target the camera

@todo describe  

      scale: (x, y, z, targetIndex) ->





#### `translate()`
- `x <number>`             distance along the x-axis
- `y <number>`             distance along the y-axis
- `z <number>`             distance along the z-axis
- `targetIndex <integer>`  (optional) a buffer-index, else target the camera

@todo describe  

      translate: (x, y, z, targetIndex) ->

Get a handy reference to the target, and its current transformation-matrix.  
@todo deal with not-found

        target = @buffers[targetIndex] or @camera
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

        if target == @camera then @camera.updateCamera()

Return this Oo3d instance (allows chaining). 

        return @




#### `render()`
Draw each buffer to the canvas. 

      render: ->
        if ! @gl then throw Error "The WebGL rendering context is #{ªtype @gl}"
        @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT
        index = @buffers.length
        while index--

Set the current buffer in `@buffers` as the one to be worked on. The previous 
binding is automatically broken. 

+ `target <integer>`      specify what the buffer contains: 
  * `ARRAY_BUFFER`          contains vertex attributes - use `drawArrays()`
  * `ELEMENT_ARRAY_BUFFER`  contains only indices - use `drawElements()`
+ `buffer <WebGLBuffer>`  a WebGLBuffer object to bind to the target
- `<undefined>`           does not return anything

          @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[index].positionBuffer


Specify the attribute-location and data-format for the newly bound buffer. 

+ `index <WebGLUniformLocation>`  location of target attribute in the buffer
+ `size <integer>`        components per attribute: 1, 2, 3 or (default) 4
+ `type <integer>`        the data type of each component in the array: 
  * `BYTE`                  signed 8-bit two’s complement value, -128 to +127
  * `FIXED`                 16-bit fixed-point two’s complement value
  * `FLOAT` (default)       32-bit single-precision floating-point value
  * `SHORT`                 signed 16-bit two’s complement value
  * `UNSIGNED_BYTE`         unsigned 8-bit value
  * `UNSIGNED_SHORT`        unsigned 16-bit value
+ `normalized <boolean>`  Must be `FALSE` if `type` is `FIXED` or `FLOAT`
  * `TRUE`                  integers represent [-1,1] if signed, [0,1] if not
  * `FALSE`                 values are converted to fixed-point when accessed
+ `stride <integer>`      default is 0, max is 255, must be multiple of `type`, 
                          defines the byte offset between consecutive attributes
+ `pointer <integer>`     default is 0, must be multiple of `type`, defines the 
                          first component’s first attribute’s offset
- `<undefined>`           does not return anything

          @gl.vertexAttribPointer @aVtxPositionLoc, 3, @gl.FLOAT, false, 0, 0


Repeat the two steps above, for the vertex-colors. 

          @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[index].colorBuffer
          @gl.vertexAttribPointer @aVtxColorLoc, 4, @gl.FLOAT, false, 0, 0

Set the transform. 

          @gl.uniformMatrix4fv(
            @uMatTransformLoc,
            false,
            new Float32Array @buffers[index].matTransform
          )


Render geometric primitives, using the currently bound vertex data. 

+ `mode <integer>`   the kind of geometric primitives to render:
  * `POINTS`           a single dot per vertex, so 10 vertices draws 10 dots
  * `LINES`            lines between vertex pairs, 10 vertices draws 5 lines
  * `LINE_STRIP`       join all vertices using lines, 10 vertices draws 9 lines
  * `LINE_LOOP`        as LINE_STRIP but connects last vertex back to the first
  * `TRIANGLES`        a triangle for each set of three consecutive vertices
  * `TRIANGLE_STRIP`   vertex 4 adds a new triangle after the 1st has been drawn
  * `TRIANGLE_FAN`     like TRIANGLE_STRIP, but creates a fan shaped output
+ `first <integer>`  the first element to render in the array of vector points
+ `count <integer>`  the number of vector points to render, eg 3 for a triangle
- `<undefined>`      does not return anything

          @gl.drawArrays @gl.TRIANGLES, 0, @buffers[index].count

@todo describe

          @gl.flush()




Functions
---------


#### `getVertexSource() <string>` and `getFragmentSource() <string>`
Many WebGL tutorials read these strings from `<SCRIPT>` elements. But for 
simplicity, `initShaders()` just grabs the strings from these functions. 

    getVertexSource = -> """
      attribute vec3 aVtxPosition;
      attribute vec4 aVtxColor;

      uniform mat4 uMatTransform;
      uniform mat4 uMatCamera;

      varying vec4 vColor; // declare `vColor`

      void main() {

        // Multiply the position by the camera transformation and matrices
        // Note that the order of these three is important
        gl_Position = uMatCamera * uMatTransform * vec4(aVtxPosition, 1);

        // Convert from clipspace to colorspace, and send to the fragment-shader
        // Clipspace goes -1.0 to +1.0
        // Colorspace goes from 0.0 to 1.0
        // vColor = gl_Position * 0.5 + 0.5; //vec4(4,4,4,4);

        // Just pass the vertex-color attribute unchanged to the fragment-shader
        vColor = aVtxColor;
      }
      """

    getFragmentSource = -> """
      precision mediump float; // boilerplate for mobile-friendly shaders
      varying vec4 vColor;     // linear-interpolated input from fragment-shader

      void main(void) {
        gl_FragColor = vColor;
      }
      """


