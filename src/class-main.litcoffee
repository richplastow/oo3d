Main
====

@todo describe




Glossary
--------


#### Vertex attribute
Data such as vertex coordinates, texture coordinate data, per-vertex color 
data, and normals. 


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


#### `vertexShader <WebGLShader|null>` and `fragmentShader <WebGLShader|null>`
Xx. 

        @vertexShader   = null
        @fragmentShader = null


#### `program <WebGLProgram|null>`
Xx. 

        @program = null


#### `aVtxPositionLoc <integer|null>` and `aVtxColorLoc <integer|null>`
Locations of attributes `aVtxPosition` and `aVtxColor` in the shader program. 

        @aVtxPositionLoc = null
        @aVtxColorLoc    = null


#### `matTransform <array|null>` and `matProjection <array|null>`
The current transformation and projection, as standard JavaScript arrays. 

        @matTransform  = null
        @matProjection = null


#### `uMatTransformLoc <integer|null>` and `uMatProjectionLoc <integer|null>`
Index of the transformation and projection uniforms `uMatTransform` and 
`uMatProjection` in the shader program. 

        @uMatTransformLoc  = null
        @uMatProjectionLoc = null


#### `buffer <array of WebGLBuffers>`
Contains all current buffers. 

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
            @initProjection()
            @initTransform()




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
Set the canvas context background to black, and set various WebGL parameters.  
[From MDN’s first WebGL article, again.](https://goo.gl/DYPEVk)  
1. Set clear-color to opaque #6668B4  
2. Enable depth testing  
3. Near things obscure far things  
4. Clear the color as well as the depth buffer
5. Set the viewport to the canvas width and height

      initCanvas: ->
        @gl.clearColor 0.3984375, 0.40625, 0.703125, 1.0
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


Switch on the vertex-position and vertex-color attributes. 

+ `index <integer>`  the index of the vertex attribute which should be enabled
- `<undefined>`      does not return anything

        @gl.enableVertexAttribArray @aVtxPositionLoc
        @gl.enableVertexAttribArray @aVtxColorLoc


Get the index of the transformation-matrix and projection-matrix uniforms. 

        @uMatTransformLoc  = @gl.getUniformLocation @program, 'uMatTransform'
        @uMatProjectionLoc = @gl.getUniformLocation @program, 'uMatProjection'




#### `cleanUp()`
Xx.  

      cleanUp: ->
        if @vertexShader   then @gl.deleteShader @vertexShader
        if @fragmentShader then @gl.deleteShader @fragmentShader
        if @program        then @gl.deleteProgram @program




#### `initProjection()`
Xx.  
[From a rozengain.com tutorial.](http://goo.gl/d0dHuj)  
[Wikipedia Viewing-Frustrum](https://goo.gl/DCslVo)  

      initProjection: ->

        #fieldOfView = 20.0
        #aspectRatio = @$main.width / @$main.height
        #nearPlane = 0.1
        #farPlane = 10000.0
        #top = nearPlane * Math.tan(fieldOfView * Math.PI / 360.0)
        #bottom = -top
        #right = top * aspectRatio
        #left = -right

Create the initial perspective-matrix manually. The OpenGL function that’s 
normally used for this, `glFrustum()`, is not included in the WebGL API. 

        #a = (right + left) / (right - left)
        #b = (top + bottom) / (top - bottom)
        #c = (farPlane + nearPlane) / (farPlane - nearPlane)
        #d = (2 * farPlane * nearPlane) / (farPlane - nearPlane)
        #x = (2 * nearPlane) / (right - left)
        #y = (2 * nearPlane) / (top - bottom)

Set the perspective-matrix. 

        #@matProjection = [
        #  x,  0,  a,  0
        #  0,  y,  b,  0
        #  0,  0,  c,  d
        #  0,  0, -1,  0
        #]

        @matProjection = mat4.perspective(
          1                            # fovy
          @$main.width / @$main.height # aspect
          0.1                          # near
          1000.0                       # far
        )
        @matProjection = mat4.rotateY   @matProjection, 0.9
        @matProjection = mat4.translate @matProjection, 2, -2, -7
        @gl.uniformMatrix4fv(
          @uMatProjectionLoc,
          false,
          new Float32Array(@matProjection)
        )



#### `initTransform()`
Xx.  

      initTransform: ->

        @matTransform = [
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,  0,  1
        ]
        @gl.uniformMatrix4fv(
          @uMatTransformLoc,
          false,
          new Float32Array(@matTransform)
        )




API Methods
-----------


#### `addBuffer()`
- `config <object>`
- `config.positions <array>`  x, y, and z coordinates (each [-1,1])
- `config.colors <array>`     (optional) r, g, b, and alpha (each [0,1])
- `<integer>`                 index of the newly added buffer in `@buffers`

`config.positions` must be defined using ‘clipspace’ coordinates, which always 
go from -1 to +1, regardless of canvas size.  
If `config.colors` is not specified, all vertices are set to 50% opacity grey.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      addBuffer: (config) ->

Record a new instance of the `Buffer` class in `buffers`, and get its index. 

        index = @buffers.length
        @buffers[index] = new Buffer config, @gl

Return the index of the newly added buffer in `@buffers`. 

        index




#### `transform()`
- `config <object>`
- `config.target <integer>`  (optional) a buffer-index, else transform the scene
- `config.type <string>`     'rotateY'
- `config.rad <number>`      (optional) if 'rotate', an angle, in radians
- `config.x <number>`        (optional) if 'translate', a distance
- `config.y <number>`        (optional) if 'translate', a distance
- `config.z <number>`        (optional) if 'translate', a distance

@todo describe  

      transform: (config) ->

        ª 'BEFORE:', JSON.stringify @matTransform
        switch config.type

          when 'rotateY'
            @matTransform = mat4.rotateY   @matTransform, config.rad
          when 'translate'
            @matTransform = mat4.translate @matTransform, config.x or 0, config.y or 0, config.z or 0

        ª 'AFTER:', JSON.stringify @matTransform

Apply the transform to the `uMatTransform` uniform in the vertex-shader. 

        @gl.uniformMatrix4fv(
          @uMatTransformLoc,
          false,
          new Float32Array(@matTransform)
        )




#### `render()`
Draw each buffer to the canvas. 

      render: ->
        if ! @gl then throw Error "The WebGL rendering context is #{ªtype @gl}"
        index = @buffers.length
        while index--

Set the current buffer in `@buffers` as the one to be worked on. The previous 
binding is automatically broken. 

+ `target <integer>`      specify what the buffer contains: 
  * `ARRAY_BUFFER`          contains vertex attributes - use `drawArrays()`
  * `ELEMENT_ARRAY_BUFFER`  contains only indices - use `drawElements()`
+ `buffer <WebGLBuffer>`  a WebGLBuffer object to bind to the target
- `<undefined>`           does not return anything

          @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[index].positions


Specify the attribute-location and data-format for the newly bound buffer. 

+ `index <integer>`       index of target attribute in the buffer bound to gl.ARRAY_BUFFER
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

          @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[index].colors
          @gl.vertexAttribPointer @aVtxColorLoc, 4, @gl.FLOAT, false, 0, 0


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

          @gl.drawArrays @gl.TRIANGLES, 0, 3

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
      uniform mat4 uMatProjection;

      varying vec4 vColor; // declare `vColor`

      void main() {

        // Multiply the position by the transformation and projection matrices
        gl_Position = vec4(aVtxPosition, 1) * uMatTransform * uMatProjection;

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


