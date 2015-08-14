Camera
======


@todo describe

    class Camera
      C: 'Camera'
      toString: -> "[object #{@C}]"

      constructor: (@main, config={}) ->
        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
Xx. @todo describe

        if ªO != ªtype @main then throw TypeError "
          `main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          `main` must be [object Oo3d] not #{@main}"


#### `fovy <number>`
@todo describe

        @fovy = config.fovy
        if ! @fovy then @fovy = 0.785398163 # 45º
        else if 'number' != ªtype @fovy then throw TypeError "
          If set, config.fovy must be number not #{ªtype @fovy}"
        else if 0 >= @fovy then throw RangeError "
          If set, config.fovy must be greater than 0 not #{@fovy}"


#### `aspect <number>`
@todo describe

        @aspect = config.aspect
        if ! @aspect then @aspect = @main.$main.width / @main.$main.height
        else if 'number' != ªtype @aspect then throw TypeError "
          If set, config.aspect must be number not #{ªtype @aspect}"
        else if 0 >= @aspect then throw RangeError "
          If set, config.aspect must be greater than 0 not #{@aspect}"


#### `uMatCameraLoc <WebGLUniformLocation|null>`
Get the location of the 'uMatCamera' uniform in the Vertex Shader. 
@todo remove, as moved elsewhere

        #@uMatCameraLoc = @main.gl.getUniformLocation @main.program, 'uMatCamera'


#### `rX, rY, rZ <number>`
Keep track of rotation currently applied to this camera. All start at 0. 

        @rX = 0
        @rY = 0
        @rZ = 0


#### `sX, sY, sZ <number>`
Keep track of scale currently applied to this camera. All start at 1. 

        @sX = 1
        @sY = 1
        @sZ = 1


#### `tX, tY, translateZ <number>`
Keep track of translation currently applied to this camera. Starts at (0,0,-4). 

        @tX = 0
        @tY = 0
        @tZ = -4 # starts at Z = -4


#### `matTransform <array>`
The transformation-matrix currently applied to this camera. Starts at (0,0,-4).

        @matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0, -4,  1 # starts at Z = -4
        ])


#### `matProjection <array|null>`
The projection-matrix currently applied to this camera. 

        @matProjection = mat4.perspective(
          @fovy,
          @aspect,
          1,   # near
          100  # far
        )
        ª @fovy, @aspect


#### `matCamera <array|null>`
Result of the camera-projection multiplied by the camera-transformation. 
Its initial value is calculated by calling `updateCamera()`. 

        @matCamera = null
        @updateCamera()




Methods
-------


#### `updateCamera()`
Calculate the camera-matrix, and update the 'uMatCamera' uniform. @todo remove commented block, as moved elsewhere

      updateCamera: ->
        @matCamera = new Float32Array mat4.multiply @matProjection, @matTransform
        #@main.gl.uniformMatrix4fv(
        #  @uMatCameraLoc,
        #  false,
        #  new Float32Array @matCamera
        #)




Methods
-------


#### `xx()`
Xx. 

      xx: ->




