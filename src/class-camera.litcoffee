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


#### `matCameraProjection <array|null>`
The projection-matrix currently applied to this camera. 

        @matCameraProjection = mat4.perspective(
          @fovy,
          @aspect,
          1,   # near
          100  # far
        )


#### `matCameraTransform <array>`
The transformation-matrix currently applied to this camera. Starts at identity. 

        @matCameraTransform = [
          1,  0,  0,  0
          0,  1,  0,  0
          0,  0,  1,  0
          0,  0, -5,  1 # starts at Z = -5
        ]


#### `matCamera <array|null>`
Result of the camera-projection multiplied by the camera-transformation. 
Will be intialized by `updateCamera()`, below. 

        @matCamera = null


#### `uMatCameraLoc <WebGLUniformLocation|null>`
Get the location of the 'uMatCamera' uniform in the Vertex Shader. 

        @uMatCameraLoc = @gl.getUniformLocation @program, 'uMatCamera'


#### `rotateX, rotateY, rotateZ <number>`
Keep track of rotation currently applied to this camera. 

        @rotateX = 0
        @rotateY = 0
        @rotateZ = 0


#### `translateX, translateY, translateZ <number>`
Keep track of translation currently applied to this camera. 

        @translateX = 0
        @translateY = 0
        @translateZ = -5 # starts at Z = -5




Init
----


Calculate the initial camera-matrix, and update the 'uMatCamera' uniform. 

        @updateCamera()




Init Methods
------------


#### `updateCamera()`
Calculate the camera-matrix, and update the 'uMatCamera' uniform. 

      updateCamera: ->
        @matCamera = mat4.multiply @matCameraProjection, @matCameraTransform
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



