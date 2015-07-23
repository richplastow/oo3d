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
Xx. @todo describe

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


#### `buffer <WebGLBuffer|null>`
Xx. 

        @buffer = null




Init
----

Initialize the instance, if `@$main` has been defined. 

        if @$main
          @initWebGL()
          if @gl
            @initCanvas()
            @initShaders()
            @initShaderProgram()
            @initBuffer new Float32Array [
                0.0,  0.8,  0.0
               -0.9, -0.8,  0.0
                0.7, -0.9,  0.0
              ]




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
        if ! @gl
          alert "Unable to initialize WebGL. Your browser may not support it."
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
Create the two types of shader, and compile them with the proper source code.  
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

Xx. 

        #@uColorRef = @gl.getUniformLocation @shaderProgram, 'uColor'
        #@gl.uniform4fv @aVertexColorRef, new Float32Array(0.8,0.2,0.3,0.7)




#### `initBuffer()`
- `vertices <Float32Array>`  an array of x, y, z points (each -1 to +1)

Xx.  
‘Clipspace’ coordinates always go from -1 to +1, regardless of the canvas size. 
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      initBuffer: (vertices) ->

Create the buffer, and add the vertices to it. 

        @buffer = @gl.createBuffer()
        @gl.bindBuffer @gl.ARRAY_BUFFER, @buffer
        @gl.bufferData @gl.ARRAY_BUFFER, vertices, @gl.STATIC_DRAW




#### `render()`
Xx.  
[From MDN’s second WebGL article, again.](https://goo.gl/q6YFNe)  

      render: ->
        if ! @gl then throw Error "The WebGL rendering context is #{ªtype @gl}"
        @gl.vertexAttribPointer @aVertexPosRef, 3, @gl.FLOAT, false, 0, 0
        @gl.drawArrays @gl.TRIANGLES, 0, 3




Functions
---------


#### `getVertexSource() <string>` and `getFragmentSource() <string>`
Many WebGL tutorials read these strings from `<SCRIPT>` elements. But for 
simplicity, `initShaders()` just grabs the strings from these functions. 

    #getVertexSource = -> """
    #  attribute vec3 aVertexPos;

    #  uniform mat4 uMVMatrix;
    #  uniform mat4 uPMatrix;
    #  
    #  void main(void) {
    #    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPos, 1.0);
    #  }
    #  """


    getVertexSource = -> """
      attribute vec2 aVertexPos;

      varying vec4 vColor;     // declare `vColor`

      void main() {
        gl_Position = vec4(aVertexPos, 0, 1);
        vColor = gl_Position * vec4(4,4,4,4); // send to the fragment shader
      }
      """

    #getFragmentSource = -> """
    #  void main(void) {
    #    gl_FragColor = vec4(0.2,1,0,0.7); // green
    #  }
    #  """


    #getFragmentSource = -> """
    #  precision mediump float;

    #  varying vec2 vPosition;
    #  uniform sampler2D webcam;

    #  float wave(float x, float amount) {
    #    return (sin(x * amount) + 1.) * .5;
    #  }

    #  void main() {
    #    vec4 color = texture2D(webcam, vPosition);
    #    gl_FragColor.r = wave(color.r, 10.);
    #    gl_FragColor.g = wave(color.g, 20.);
    #    gl_FragColor.b = wave(color.b, 40.);
    #    gl_FragColor.a = 1.;
    #  }
    #  """


    getFragmentSource = -> """
      precision mediump float; // boilerplate for mobile-friendly shaders
      varying vec4 vColor;     // linear-interpolated input from fragment-shader

      void main(void) {
        gl_FragColor = vColor;
      }
      """


