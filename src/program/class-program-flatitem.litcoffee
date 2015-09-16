Program.FlatItem
================


#### Xx @todo describe




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Program.FlatItem’s index in `main._all`
- `config <object>`  (optional) configuration and options

    class Program.FlatItem extends Program
      C: 'Program.FlatItem'
      toString: -> "[object FlatItem]"


      constructor: (main, index, config={}) ->
        M = "/oo3d/src/program/class-program-flatitem.litcoffee
          Program.FlatItem##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `vertexShader <WebGLShader>` (inherited)
#### `fragmentShader <WebGLShader>` (inherited)
#### `program <WebGLProgram>` (inherited)




Properties
----------


Get a handy reference to the WebGL context. 

        gl = @main.gl


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


#### `uMeshColorLoc <WebGLUniformLocation>`
Get the location of the `uMeshColor` uniforms. 

        @uMeshColorLoc = gl.getUniformLocation @program, 'uMeshColor'




Methods
-------


#### `vertexSource()`
Simply draws the transformed vertices. 

      vertexSource: -> """
      attribute vec3 aVtxPosition;

      uniform mat4 uMatTransform;
      uniform mat4 uMatCamera;

      uniform vec4 uMeshColor; // the mesh renders as a single flat color


      varying vec4 vColor; // declare `vColor`

      void main() {

        //// Multiply the position by the camera transformation and matrices. 
        //// Note that the order of these three is important. 
        gl_Position = uMatCamera * uMatTransform * vec4(aVtxPosition, 1);

        //// Pass the vertex-color attribute unchanged to the fragment-shader. 
        vColor = uMeshColor;

      }
      """




#### `fragmentSource()`
Renders every fragment as a single flat color. 

      fragmentSource: -> """
      precision mediump float; // boilerplate for mobile-friendly shaders

      varying vec4 vColor; // linear-interpolated input from fragment-shader

      void main() {
        gl_FragColor = vColor;
      }
      """


