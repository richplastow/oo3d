Mat4
====

@todo describe



    mat4 = {}



Generates a perspective projection matrix with the given bounds

@param {mat4} out mat4 frustum matrix will be written into
@param {number} fovy Vertical field of view in radians
@param {number} aspect Aspect ratio. typically viewport width/height
@param {number} near Near bound of the frustum
@param {number} far Far bound of the frustum
@returns {mat4} out

    mat4.perspective = (fovy, aspect, near, far) ->
      f = 1.0 / Math.tan(fovy / 2)
      nf = 1 / (near - far)
      out = []
      out[0]  = f / aspect
      out[1]  = 0
      out[2]  = 0
      out[3]  = 0
      out[4]  = 0
      out[5]  = f
      out[6]  = 0
      out[7]  = 0
      out[8]  = 0
      out[9]  = 0
      out[10] = (far + near) * nf
      out[11] = -1
      out[12] = 0
      out[13] = 0
      out[14] = (2 * far * near) * nf
      out[15] = 0
      out




Rotates a matrix by the given angle around the Y axis
@param {mat4} a the matrix to rotate
@param {Number} rad the angle to rotate the matrix by
@returns {mat4} a

    mat4.rotateY = (a, rad) ->
      s = Math.sin rad
      c = Math.cos rad
      a00 = a[0]
      a01 = a[1]
      a02 = a[2]
      a03 = a[3]
      a20 = a[8]
      a21 = a[9]
      a22 = a[10]
      a23 = a[11]

Perform axis-specific matrix multiplication. 

      a[0]  = a00 * c - a20 * s
      a[1]  = a01 * c - a21 * s
      a[2]  = a02 * c - a22 * s
      a[3]  = a03 * c - a23 * s
      a[8]  = a00 * s + a20 * c
      a[9]  = a01 * s + a21 * c
      a[10] = a02 * s + a22 * c
      a[11] = a03 * s + a23 * c

Return the result. 

      a




Translate a mat4 by the given vector

@param {mat4} a the matrix to translate
@param {vec3} v vector to translate by
@returns {mat4} a

    mat4.translate = (a, x, y, z) ->

      a[12] = a[0] * x + a[4] * y + a[8]  * z + a[12]
      a[13] = a[1] * x + a[5] * y + a[9]  * z + a[13]
      a[14] = a[2] * x + a[6] * y + a[10] * z + a[14]
      a[15] = a[3] * x + a[7] * y + a[11] * z + a[15]

Return the result. 

      a
