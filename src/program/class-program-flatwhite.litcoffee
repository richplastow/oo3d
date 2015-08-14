Program.Flatwhite
=================


#### A simple Program for plain white shapes with no shading

    class Program.Flatwhite extends Program
      C: 'Program.Flatwhite'
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


#### `uMatTransformLoc and uMatCameraLoc <WebGLUniformLocation>`
Get the location of the `uMatTransform` and `uMatCamera` uniforms. 

        @uMatTransformLoc = gl.getUniformLocation @program, 'uMatTransform'
        @uMatCameraLoc    = gl.getUniformLocation @program, 'uMatCamera'




Methods
-------


#### `vertexSource()`
Simply draws the transformed vertices. 

      vertexSource: -> """
      attribute vec3 aVtxPosition;

      uniform mat4 uMatTransform;
      uniform mat4 uMatCamera;

      void main() {

        //// Multiply the position by the camera transformation and matrices. 
        //// Note that the order of these three is important. 
        gl_Position = uMatCamera * uMatTransform * vec4(aVtxPosition, 1);

      }
      """




#### `fragmentSource()`
Renders every fragment white. 

      fragmentSource: -> """
      precision mediump float; // boilerplate for mobile-friendly shaders

      vec4 white = vec4(1.0,1.0,1.0,1.0);

      void main() {
        gl_FragColor = white;
      }
      """


