Mat4
====

@todo describe



    mat4 = {}




Multiplies two mat4's

@param {mat4} a the first operand
@param {mat4} b the second operand
@returns {mat4} out

    mat4.multiply = (a, b) ->

      out = []
      a00 = a[0]; a01 = a[1]; a02 = a[2]; a03 = a[3];
      a10 = a[4]; a11 = a[5]; a12 = a[6]; a13 = a[7];
      a20 = a[8]; a21 = a[9]; a22 = a[10]; a23 = a[11];
      a30 = a[12]; a31 = a[13]; a32 = a[14]; a33 = a[15];

      # Cache only the current line of the second matrix
      b0  = b[0]; b1 = b[1]; b2 = b[2]; b3 = b[3];  
      out[0] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
      out[1] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
      out[2] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
      out[3] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
  
      b0 = b[4]; b1 = b[5]; b2 = b[6]; b3 = b[7];
      out[4] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
      out[5] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
      out[6] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
      out[7] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
  
      b0 = b[8]; b1 = b[9]; b2 = b[10]; b3 = b[11];
      out[8] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
      out[9] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
      out[10] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
      out[11] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
  
      b0 = b[12]; b1 = b[13]; b2 = b[14]; b3 = b[15];
      out[12] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
      out[13] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
      out[14] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
      out[15] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
      return out;




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




Rotates a matrix by the given angle around the X axis
@param {mat4} a the matrix to rotate
@param {Number} rad the angle to rotate the matrix by
@returns {mat4} a

    mat4.rotateX = (a, rad) ->
      s = Math.sin rad
      c = Math.cos rad
      a10 = a[4]
      a11 = a[5]
      a12 = a[6]
      a13 = a[7]
      a20 = a[8]
      a21 = a[9]
      a22 = a[10]
      a23 = a[11]

Perform axis-specific matrix multiplication. 

      a[4]  = a10 * c + a20 * s
      a[5]  = a11 * c + a21 * s
      a[6]  = a12 * c + a22 * s
      a[7]  = a13 * c + a23 * s
      a[8]  = a20 * c - a10 * s
      a[9]  = a21 * c - a11 * s
      a[10] = a22 * c - a12 * s
      a[11] = a23 * c - a13 * s

Return the result. 

      a




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




Rotates a matrix by the given angle around the Z axis
@param {mat4} a the matrix to rotate
@param {Number} rad the angle to rotate the matrix by
@returns {mat4} a

    mat4.rotateZ = (a, rad) ->
      s = Math.sin rad
      c = Math.cos rad
      a00 = a[0]
      a01 = a[1]
      a02 = a[2]
      a03 = a[3]
      a10 = a[4]
      a11 = a[5]
      a12 = a[6]
      a13 = a[7]

Perform axis-specific matrix multiplication. 

      a[0] = a00 * c + a10 * s
      a[1] = a01 * c + a11 * s
      a[2] = a02 * c + a12 * s
      a[3] = a03 * c + a13 * s
      a[4] = a10 * c - a00 * s
      a[5] = a11 * c - a01 * s
      a[6] = a12 * c - a02 * s
      a[7] = a13 * c - a03 * s

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




Generates a orthogonal projection matrix with the given bounds

@param {number} left Left bound of the frustum
@param {number} right Right bound of the frustum
@param {number} bottom Bottom bound of the frustum
@param {number} top Top bound of the frustum
@param {number} near Near bound of the frustum
@param {number} far Far bound of the frustum
@returns {mat4} out

    mat4.ortho = (left, right, bottom, top, near, far) ->
      lr = 1 / (left - right)
      bt = 1 / (bottom - top)
      nf = 1 / (near - far)
      out = []
      out[0] = -2 * lr
      out[1] = 0
      out[2] = 0
      out[3] = 0
      out[4] = 0
      out[5] = -2 * bt
      out[6] = 0
      out[7] = 0
      out[8] = 0
      out[9] = 0
      out[10] = 2 * nf
      out[11] = 0
      out[12] = (left + right) * lr
      out[13] = (top + bottom) * bt
      out[14] = (far + near) * nf
      out[15] = 1
      return out



From http://www.html5rocks.com/en/tutorials/webgl/webgl_transforms/

    mat4.makeTranslation = (tx, ty, tz) ->
      [
        1,  0,  0,  0
        0,  1,  0,  0
        0,  0,  1,  0
        tx, ty, tz, 1
      ]


    mat4.makeXRotation = (angleInRadians) ->
      c = Math.cos angleInRadians
      s = Math.sin angleInRadians
      [
        1,  0,  0,  0
        0,  c,  s,  0
        0, -s,  c,  0
        0,  0,  0,  1
      ]


    mat4.makeYRotation = (angleInRadians) ->
      c = Math.cos angleInRadians
      s = Math.sin angleInRadians
      [
        c,  0, -s,  0
        0,  1,  0,  0
        s,  0,  c,  0
        0,  0,  0,  1
      ]


    mat4.makeZRotation = (angleInRadians) ->
      c = Math.cos angleInRadians
      s = Math.sin angleInRadians
      [
        c,  s,  0,  0
       -s,  c,  0,  0
        0,  0,  1,  0
        0,  0,  0,  1
      ]


    mat4.makeScale = (sx, sy) ->
      [
        sx, 0,  0,  0
        0,  sy, 0,  0
        0,  0,  sz, 0
        0,  0,  0,  1
      ]


    mat4.makeProjection = (width, height, depth) ->
      [
        2 / width, 0,           0,         0
        0,         -2 / height, 0,         0
        0,         0,           2 / depth, 0
        -1,        1,           0,         1
      ]



