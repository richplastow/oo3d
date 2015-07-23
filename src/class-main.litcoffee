Main
====

@todo describe


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
after `initWebGL()` has been run. 

        @gl = null


#### `fragmentShader <WebGLShader|null>` and `vertexShader <WebGLShader|null>`
Xx. 

        @fragmentShader = null
        @vertexShader   = null


#### `aVertexPosRef <integer|null>`
Vertex position attribute reference. 

        @aVertexPosRef = null


#### `uColorRef <integer|null>`
Color uniform reference. 

        @uColorRef = null


#### `shaderProgram <WebGLProgram|null>`
Xx. 

        @shaderProgram = null


#### `buffer <array of WebGLBuffers>`
Contains all current buffers. 

        @buffers = []




Init
----

Initialize the instance, if `@$main` has been defined. 

        if @$main
          @initWebGL()
          if @gl
            @initCanvas()
            @initShaders()
            @initShaderProgram()




Methods
-------


#### `initWebGL()`
Try to grab the standard WebGL context. If it fails, fallback to experimental. 
If that fails, show an error alert. [From MDN’s article.](https://goo.gl/DYPEVk)

      initWebGL: ->
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

      initCanvas: ->
        @gl.clearColor 0.3984375, 0.40625, 0.703125, 1.0
        @gl.enable @gl.DEPTH_TEST
        @gl.depthFunc @gl.LEQUAL
        @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT




#### `initShaders()`
Create the two types of shader. Compile them from source code defined below.  
[From MDN’s second WebGL article.](https://goo.gl/q6YFNe)  

      initShaders: ->
        @fragmentShader = @gl.createShader @gl.FRAGMENT_SHADER
        @vertexShader   = @gl.createShader @gl.VERTEX_SHADER
        @gl.shaderSource @fragmentShader, getFragmentSource()
        @gl.shaderSource @vertexShader  , getVertexSource()
        @gl.compileShader @fragmentShader
        @gl.compileShader @vertexShader

Check that they compiled successfully. 

        if ! @gl.getShaderParameter @fragmentShader, @gl.COMPILE_STATUS
          throw Error "@fragmentShader did not compile successfully"
        if ! @gl.getShaderParameter @vertexShader,   @gl.COMPILE_STATUS
          throw Error "@vertexShader did not compile successfully"




#### `initShaderProgram()`
Xx.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      initShaderProgram: ->
        @shaderProgram = @gl.createProgram()
        @gl.attachShader @shaderProgram, @fragmentShader
        @gl.attachShader @shaderProgram, @vertexShader
        @gl.linkProgram @shaderProgram

Check that it linked successfully. 

        if ! @gl.getProgramParameter @shaderProgram, @gl.LINK_STATUS
          throw Error "@shaderProgram did not link successfully"

Xx. 

        @gl.useProgram @shaderProgram

Xx. 

        @aVertexPosRef = @gl.getAttribLocation @shaderProgram, 'aVertexPos'
        @gl.enableVertexAttribArray @aVertexPosRef




#### `initBuffer()`
- `vertices <array>`  an array of x, y, z points (each -1 to +1)

Xx.  
‘Clipspace’ coordinates always go from -1 to +1, regardless of the canvas size. 
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      initBuffer: (vertices) ->

Create the buffer, and add the vertices to it. 

        @buffers.push @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[0]
        @gl.bufferData @gl.ARRAY_BUFFER, new Float32Array(vertices), @gl.STATIC_DRAW




#### `addBuffer()`
- `<integer>`         index of the newly added buffer in `@buffers`
- `vertices <array>`  an array of x, y, z points (each -1 to +1)

Xx.  
‘Clipspace’ coordinates always go from -1 to +1, regardless of canvas size.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      addBuffer: (vertices) ->

Get the index of the newly added buffer. 

        index = @buffers.length

Instantiate a `WebGLBuffer`, and add the vertices to it. 

        @buffers.push @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[index]
        @gl.bufferData @gl.ARRAY_BUFFER, new Float32Array(vertices), @gl.STATIC_DRAW

Return the index of the newly added buffer in `@buffers`. 

        index




#### `render()`
Xx.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      render: ->
        if ! @gl then throw Error "The WebGL rendering context is #{ªtype @gl}"
        index = @buffers.length
        while index--
          @gl.bindBuffer @gl.ARRAY_BUFFER, @buffers[index]
          @gl.vertexAttribPointer @aVertexPosRef, 3, @gl.FLOAT, false, 0, 0
          @gl.drawArrays @gl.TRIANGLES, 0, 3




Functions
---------


#### `getVertexSource() <string>` and `getFragmentSource() <string>`
Many WebGL tutorials read these strings from `<SCRIPT>` elements. But for 
simplicity, `initShaders()` just grabs the strings from these functions. 

    getVertexSource = -> """
      attribute vec2 aVertexPos;

      varying vec4 vColor;     // declare `vColor`

      void main() {
        gl_Position = vec4(aVertexPos, 0, 1);
        vColor = gl_Position * vec4(4,4,4,4); // send to the fragment shader
      }
      """

    getFragmentSource = -> """
      precision mediump float; // boilerplate for mobile-friendly shaders
      varying vec4 vColor;     // linear-interpolated input from fragment-shader

      void main(void) {
        gl_FragColor = vColor;
      }
      """


