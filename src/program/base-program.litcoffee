Program
=======


#### The base class for all Programs

- Contains a vertex shader and a fragment shader
- Each Renderer must use one Program
- A Program can be used by any number of Renderers
- All Programs are stored in the main.programs array


    class Program
      C: 'Program'
      toString: -> "[object #{@C}]"

      constructor: (@main, config={}) ->
        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Program. 

        if ªO != ªtype @main then throw TypeError "
          `main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          `main` must be [object Oo3d] not #{@main}"

Get a handy reference to the WebGL context. 

        gl = @main.gl


#### `vertexShader <WebGLShader>`
Compile the vertex shader from `vertexSource()`. Note that a child Program 
class will usually override the base `vertexSource()` method. 

        @vertexShader = gl.createShader gl.VERTEX_SHADER
        gl.shaderSource @vertexShader, @vertexSource()
        gl.compileShader @vertexShader
        if ! gl.getShaderParameter @vertexShader, gl.COMPILE_STATUS
          @cleanUp(); throw Error "#{@C}.vertexShader failed to compile"


#### `fragmentShader <WebGLShader>`
Compile the fragment shader from `fragmentSource()`. Note that a child Program 
class will usually override the base `fragmentSource()` method. 

        @fragmentShader = gl.createShader gl.FRAGMENT_SHADER
        gl.shaderSource @fragmentShader, @fragmentSource()
        gl.compileShader @fragmentShader
        if ! gl.getShaderParameter @fragmentShader, gl.COMPILE_STATUS
          @cleanUp(); throw Error "#{@C}.fragmentShader failed to compile"


#### `program <WebGLProgram>`
Xx. 

        @program = gl.createProgram()
        gl.attachShader @program, @vertexShader
        gl.attachShader @program, @fragmentShader
        gl.linkProgram @program
        if ! gl.getProgramParameter @program, gl.LINK_STATUS
          @cleanUp(); throw Error "#{@C}.program failed to link"




Methods
-------


#### `cleanUp()`
Xx. 

      cleanUp: ->
        if @vertexShader   then @main.gl.deleteShader @vertexShader
        if @fragmentShader then @main.gl.deleteShader @fragmentShader
        if @program        then @main.gl.deleteProgram @program




#### `vertexSource()`
The base Program has a kind of ‘noop’ vertex shader. 

      vertexSource: -> """
      void main() {
      }
      """




#### `fragmentSource()`
The base Program has a kind of ‘noop’ fragment shader. 

      fragmentSource: -> """
      void main() {
      }
      """


