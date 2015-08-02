Camera
======

@todo describe

    class Camera
      C: 'Camera'
      toString: -> "[object #{@C}]"

      constructor: (scene, config={}) ->

Record all config as instance properties. 

        @[k] = v for k,v of config




Properties
----------


#### `gl <WebGLRenderingContext>`
WebGL context, passed from the `Main` instance. 

        @gl = scene.gl
        if 'webglrenderingcontext' != ªtype @gl then throw Error """
          scene.gl must be WebGLRenderingContext not #{ªtype @gl}"""


#### `program <WebGLProgram>`
WebGL context’s program, passed from the `Main` instance. 

        @program = scene.program
        if 'webglprogram' != ªtype @program then throw Error """
          scene.program must be WebGLProgram not #{ªtype @program}"""


#### `matProjection <array|null>`
The projection-matrix currently applied to this camera. 

        @matProjection = mat4.perspective(
          @fovy,
          @aspect,
          1,   # near
          100  # far
        )


#### `matTransform <array>`
The transformation-matrix currently applied to this camera. Starts at (0,0,-10).

        @matTransform = new Float32Array([
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0,-10,  1 # starts at Z = -10
        ])


#### `matCamera <array|null>`
Result of the camera-projection multiplied by the camera-transformation. 
Will be intialized by `updateCamera()`, below. 

        @matCamera = null


#### `uMatCameraLoc <WebGLUniformLocation|null>`
Get the location of the 'uMatCamera' uniform in the Vertex Shader. 

        @uMatCameraLoc = @gl.getUniformLocation @program, 'uMatCamera'


#### `rX, rY, rZ <number>`
Keep track of rotation currently applied to this camera. All start at 0. 

        @rX = 0
        @rY = 0
        @rZ = 0


#### `sX, sY, sZ <number>`
Keep track of rotation currently applied to this camera. All start at 1.  

        @sX = 1
        @sY = 1
        @sZ = 1


#### `tX, tY, translateZ <number>`
Keep track of translation currently applied to this camera. Starts at (0,0,-10).

        @tX = 0
        @tY = 0
        @tZ = -10 # starts at Z = -10




Init
----


Calculate the initial camera-matrix, and update the 'uMatCamera' uniform. 

        @updateCamera()




Init Methods
------------


#### `updateCamera()`
Calculate the camera-matrix, and update the 'uMatCamera' uniform. 

      updateCamera: ->
        @matCamera = mat4.multiply @matProjection, @matTransform
        @gl.uniformMatrix4fv(
          @uMatCameraLoc,
          false,
          new Float32Array @matCamera
        )




Methods
-------


#### `xx()`
Xx. 

      xx: ->




