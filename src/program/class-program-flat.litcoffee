Program.Flat
============


#### A simple Program for vertex-colored shapes with no shading

    class Program.Flat extends Program
      C: 'Program.Flat'
      toString: -> "[object #{@C}]"

      constructor: (main, config={}) ->
        super main, config

Get a handy reference to the WebGL context. 

        gl = @main.gl




Properties
----------


The WebGL specs say that locations can be got as soon as the program is linked. 
But some implementations may require that we also `useprogram()` before getting 
the locations, [according to wiki.lwjgl.org.](http://goo.gl/HBuA8U)

        gl.useProgram @program


#### `aVtxPositionLoc <integer>`
Get the index of the vertex-position attribute in the program we just created. 
The index allows us to switch on this attribute, and bind each position buffer 
to `aVtxPosition`. Then, enable the vertex-position attribute. 

        @aVtxPositionLoc = gl.getAttribLocation @program, 'aVtxPosition'
        gl.enableVertexAttribArray @aVtxPositionLoc


#### `aVtxColorLoc <integer>`
Repeat the first of the two steps above for the vertex-colors.  
The `gl.enableVertexAttribArray @aVtxColorLoc` is done before rendering, and 
then xx. 

        @aVtxColorLoc = gl.getAttribLocation @program, 'aVtxColor'


#### `uMatTransformLoc and uMatCameraLoc <WebGLUniformLocation>`
Get the location of the `uMatTransform` and `uMatCamera` uniforms. 

        @uMatTransformLoc = gl.getUniformLocation @program, 'uMatTransform'
        @uMatCameraLoc    = gl.getUniformLocation @program, 'uMatCamera'




Methods
-------


#### `vertexSource()`
Draws the transformed vertices, and sends vertex-colors to the fragment shader. 

      vertexSource: -> """
      attribute vec3 aVtxPosition;
      attribute vec4 aVtxColor;

      uniform mat4 uMatTransform;
      uniform mat4 uMatCamera;

      varying vec4 vColor; // declare `vColor`

      void main() {

        // 
        gl_PointSize = 4.0;

        //// Multiply the position by the camera transformation and matrices. 
        //// Note that the order of these three is important. 
        gl_Position = uMatCamera * uMatTransform * vec4(aVtxPosition, 1);

        // Convert from clipspace to colorspace, and send to the fragment-shader
        // Clipspace goes -1.0 to +1.0
        // Colorspace goes from 0.0 to 1.0
        // vColor = gl_Position * 0.5 + 0.5; //vec4(4,4,4,4);

        //// Pass the vertex-color attribute unchanged to the fragment-shader. 
        vColor = aVtxColor;
      }
      """




#### `fragmentSource()`
Renders every fragment according to a color passed from the vertex shader. 

      fragmentSource: -> """
      precision mediump float; // boilerplate for mobile-friendly shaders
      varying vec4 vColor;     // linear-interpolated input from fragment-shader

      void main(void) {
        gl_FragColor = vColor;
      }
      """


