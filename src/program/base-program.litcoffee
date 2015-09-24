Program
=======


#### The base class for all Programs

- Contains a vertex shader and a fragment shader
- Each Renderer must use one Program
- A Program can be used by any number of Renderers
- All Programs are stored in the main.programs array

@todo describe

    class Program
      C: 'Program'
      toString: -> "[object Program]"




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Layer’s index in `main._all`
- `config <object>`  (optional) configuration and options

@todo describe

      constructor: (@main, @index, config={}) ->
        M = "/oo3d/src/layer/base-layer.litcoffee
          Program##{+@index}()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"




Properties
----------


#### `main <Main>`
A reference to the main Oo3d instance which created this Program. 

        if ªO != typeof @main then throw TypeError "
          #{M}`main` is #{ªtype @main} not object"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` is '#{@main}' not '[object Oo3d]'"


#### `index <integer>`
This Program’s index in `main._all`. 

        if ªN != typeof @index then throw TypeError "
          #{M}`index` is #{ªtype @index} not number"
        if ªMAX < @index or @index % 1 or 0 > @index then throw RangeError "
          #{M}`index` is #{@index} not 0 or a positive integer below 2^53"


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


