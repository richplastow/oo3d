// Generated by CoffeeScript 1.9.2

/*! Oo3d 0.0.12 //// MIT Licence //// http://oo3d.richplastow.com/ */

(function() {
  var Buffer, Camera, Main, getFragmentSource, getVertexSource, mat4, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªW, ªX, ªex, ªhas, ªisU, ªredefine, ªtype, ªuid;

  ªC = 'Oo3d';

  ªV = '0.0.12';

  ªA = 'array';

  ªB = 'boolean';

  ªE = 'error';

  ªF = 'function';

  ªN = 'number';

  ªO = 'object';

  ªR = 'regexp';

  ªS = 'string';

  ªU = 'undefined';

  ªX = 'null';

  ªW = this;

  ª = console.log.bind(console);

  ªex = function(x, a, b) {
    var pos;
    if (-1 === (pos = a.indexOf(x))) {
      return x;
    } else {
      return b.charAt(pos);
    }
  };

  ªhas = function(h, n, t, f) {
    if (t == null) {
      t = true;
    }
    if (f == null) {
      f = false;
    }
    if (-1 !== h.indexOf(n)) {
      return t;
    } else {
      return f;
    }
  };

  ªtype = function(x) {
    return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
  };

  ªisU = function(x) {
    return ªU === typeof x;
  };

  ªuid = function(p) {
    return p + '_' + (Math.random() + '1111111111111111').slice(2, 18);
  };

  ªredefine = function(obj, name, value, kind) {
    switch (kind) {
      case 'constant':
        return Object.defineProperty(obj, name, {
          value: value,
          enumerable: true
        });
      case 'private':
        return Object.defineProperty(obj, name, {
          value: value,
          enumerable: false
        });
    }
  };

  Buffer = (function() {
    Buffer.prototype.C = 'Buffer';

    Buffer.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Buffer(config, gl) {
      var i, j, k, ref, v;
      if (config == null) {
        config = {};
      }
      for (k in config) {
        v = config[k];
        this[k] = v;
      }
      this.gl = gl;
      if ('webglrenderingcontext' !== ªtype(this.gl)) {
        throw Error("gl must be WebGLRenderingContext not " + (ªtype(this.gl)));
      }
      if (ªA !== ªtype(config.positions)) {
        throw Error("config.positions must be an array not " + (ªtype(config.positions)));
      }
      if (config.positions.length % 3) {
        throw Error("config.positions.length must be divisible by 3");
      }
      this.positions = this.gl.createBuffer();
      this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.positions);
      this.gl.bufferData(this.gl.ARRAY_BUFFER, new Float32Array(config.positions), this.gl.STATIC_DRAW);
      if (ªU === ªtype(config.colors)) {
        config.colors = [];
        for (i = j = 0, ref = config.positions.length / 3 * 4 - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
          config.colors.push(1);
        }
        ª(config.colors);
      } else if (ªA !== ªtype(config.colors)) {
        throw Error("config.colors must be an array not " + (ªtype(config.colors)));
      } else if (config.colors.length % 4) {
        throw Error("config.colors.length must be divisible by 4");
      } else if (config.positions.length / 3 !== config.colors.length / 4) {
        throw Error("config.colors has an incorrect vertex count");
      }
      this.colors = this.gl.createBuffer();
      this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.colors);
      this.gl.bufferData(this.gl.ARRAY_BUFFER, new Float32Array(config.colors), this.gl.STATIC_DRAW);
      this.count = config.positions.length / 3;
      this.matTransform = new Float32Array([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]);
      this.rotateX = 0;
      this.rotateY = 0;
      this.rotateZ = 0;
      this.translateX = 0;
      this.translateY = 0;
      this.translateZ = 0;
    }

    Buffer.prototype.xx = function() {};

    return Buffer;

  })();

  Camera = (function() {
    Camera.prototype.C = 'Camera';

    Camera.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Camera(scene, config) {
      var k, v;
      if (config == null) {
        config = {};
      }
      for (k in config) {
        v = config[k];
        this[k] = v;
      }
      this.gl = scene.gl;
      if ('webglrenderingcontext' !== ªtype(this.gl)) {
        throw Error("scene.gl must be WebGLRenderingContext not " + (ªtype(this.gl)));
      }
      this.program = scene.program;
      if ('webglprogram' !== ªtype(this.program)) {
        throw Error("scene.program must be WebGLProgram not " + (ªtype(this.program)));
      }
      this.matProjection = mat4.perspective(this.fovy, this.aspect, 1, 100);
      this.matTransform = new Float32Array([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, -5, 1]);
      this.matCamera = null;
      this.uMatCameraLoc = this.gl.getUniformLocation(this.program, 'uMatCamera');
      this.rotateX = 0;
      this.rotateY = 0;
      this.rotateZ = 0;
      this.translateX = 0;
      this.translateY = 0;
      this.translateZ = -5;
      this.updateCamera();
    }

    Camera.prototype.updateCamera = function() {
      this.matCamera = mat4.multiply(this.matProjection, this.matTransform);
      return this.gl.uniformMatrix4fv(this.uMatCameraLoc, false, new Float32Array(this.matCamera));
    };

    Camera.prototype.xx = function() {};

    return Camera;

  })();

  Main = (function() {
    Main.prototype.C = ªC;

    Main.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Main(config) {
      var k, v;
      if (config == null) {
        config = {};
      }
      for (k in config) {
        v = config[k];
        this[k] = v;
      }
      this.$main = config.$main || null;
      if (this.$main && ('htmlcanvaselement' !== ªtype(this.$main))) {
        throw Error("If set, config.$main must be HTMLCanvasElement not " + (ªtype(this.$main)));
      }
      this.gl = null;
      this.vertexShader = null;
      this.fragmentShader = null;
      this.program = null;
      this.aVtxPositionLoc = null;
      this.aVtxColorLoc = null;
      this.buffers = [];
      if (this.$main) {
        this.initGL();
        if (this.gl) {
          this.initCanvas();
          this.initShaders();
          this.initProgram();
          this.camera = new Camera(this, {
            fovy: 0.785398163,
            aspect: this.$main.width / this.$main.height
          });
        }
      }
    }

    Main.prototype.initGL = function() {
      try {
        this.gl = this.$main.getContext('webgl' || this.$main.getContext('experimental-webgl'));
      } catch (_error) {

      }
      if (!this.gl) {
        throw Error("Unable to initialize WebGL. Your browser may not support it.");
      }
    };

    Main.prototype.initCanvas = function() {
      this.gl.clearColor(0.3984375, 0.40625, 0.703125, 1.0);
      this.gl.enable(this.gl.DEPTH_TEST);
      this.gl.depthFunc(this.gl.LEQUAL);
      this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
      return this.gl.viewport(0, 0, this.$main.width, this.$main.height);
    };

    Main.prototype.initShaders = function() {
      this.vertexShader = this.gl.createShader(this.gl.VERTEX_SHADER);
      this.fragmentShader = this.gl.createShader(this.gl.FRAGMENT_SHADER);
      this.gl.shaderSource(this.vertexShader, getVertexSource());
      this.gl.shaderSource(this.fragmentShader, getFragmentSource());
      this.gl.compileShader(this.vertexShader);
      this.gl.compileShader(this.fragmentShader);
      if (!this.gl.getShaderParameter(this.vertexShader, this.gl.COMPILE_STATUS)) {
        this.cleanUp();
        throw Error("@vertexShader did not compile successfully");
      }
      if (!this.gl.getShaderParameter(this.fragmentShader, this.gl.COMPILE_STATUS)) {
        this.cleanUp();
        throw Error("@fragmentShader did not compile successfully");
      }
    };

    Main.prototype.initProgram = function() {
      this.program = this.gl.createProgram();
      this.gl.attachShader(this.program, this.vertexShader);
      this.gl.attachShader(this.program, this.fragmentShader);
      this.gl.linkProgram(this.program);
      if (!this.gl.getProgramParameter(this.program, this.gl.LINK_STATUS)) {
        this.cleanUp();
        throw Error("@program did not link successfully");
      }
      this.gl.useProgram(this.program);
      this.aVtxPositionLoc = this.gl.getAttribLocation(this.program, 'aVtxPosition');
      this.aVtxColorLoc = this.gl.getAttribLocation(this.program, 'aVtxColor');
      this.gl.enableVertexAttribArray(this.aVtxPositionLoc);
      this.gl.enableVertexAttribArray(this.aVtxColorLoc);
      return this.uMatTransformLoc = this.gl.getUniformLocation(this.program, 'uMatTransform');
    };

    Main.prototype.cleanUp = function() {
      if (this.vertexShader) {
        this.gl.deleteShader(this.vertexShader);
      }
      if (this.fragmentShader) {
        this.gl.deleteShader(this.fragmentShader);
      }
      if (this.program) {
        return this.gl.deleteProgram(this.program);
      }
    };

    Main.prototype.addBuffer = function(config) {
      var index;
      index = this.buffers.length;
      this.buffers[index] = new Buffer(config, this.gl);
      return index;
    };

    Main.prototype.transform = function(config) {
      var matNew, matOld, target, x, y, z;
      target = ªisU(config.target) ? this.camera : this.buffers[config.target];
      matOld = target.matTransform;
      matNew = (function() {
        switch (config.type) {
          case 'rotateX':
            target.rotateX += config.rad;
            return mat4.multiply(matOld, mat4.makeXRotation(config.rad));
          case 'rotateY':
            target.rotateY += config.rad;
            return mat4.multiply(matOld, mat4.makeYRotation(config.rad));
          case 'rotateZ':
            target.rotateZ += config.rad;
            return mat4.multiply(matOld, mat4.makeZRotation(config.rad));
          case 'translate':
            x = config.x || 0;
            y = config.y || 0;
            z = config.z || 0;
            target.translateX += x;
            target.translateY += y;
            target.translateZ += z;
            return mat4.multiply(matOld, mat4.makeTranslation(x, y, z));
        }
      })();
      target.matTransform = matNew;
      if (ªU === typeof config.target) {
        return this.camera.updateCamera();
      }
    };

    Main.prototype.render = function() {
      var index, results;
      if (!this.gl) {
        throw Error("The WebGL rendering context is " + (ªtype(this.gl)));
      }
      this.initCanvas();
      index = this.buffers.length;
      results = [];
      while (index--) {
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[index].positions);
        this.gl.vertexAttribPointer(this.aVtxPositionLoc, 3, this.gl.FLOAT, false, 0, 0);
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[index].colors);
        this.gl.vertexAttribPointer(this.aVtxColorLoc, 4, this.gl.FLOAT, false, 0, 0);
        this.gl.uniformMatrix4fv(this.uMatTransformLoc, false, new Float32Array(this.buffers[index].matTransform));
        this.gl.drawArrays(this.gl.TRIANGLES, 0, this.buffers[index].count);
        results.push(this.gl.flush());
      }
      return results;
    };

    return Main;

  })();

  getVertexSource = function() {
    return "attribute vec3 aVtxPosition;\nattribute vec4 aVtxColor;\n\nuniform mat4 uMatTransform;\nuniform mat4 uMatCamera;\n\nvarying vec4 vColor; // declare `vColor`\n\nvoid main() {\n\n  // Multiply the position by the camera transformation and matrices\n  // Note that the order of these three is important\n  gl_Position = uMatCamera * uMatTransform * vec4(aVtxPosition, 1);\n\n  // Convert from clipspace to colorspace, and send to the fragment-shader\n  // Clipspace goes -1.0 to +1.0\n  // Colorspace goes from 0.0 to 1.0\n  // vColor = gl_Position * 0.5 + 0.5; //vec4(4,4,4,4);\n\n  // Just pass the vertex-color attribute unchanged to the fragment-shader\n  vColor = aVtxColor;\n}";
  };

  getFragmentSource = function() {
    return "precision mediump float; // boilerplate for mobile-friendly shaders\nvarying vec4 vColor;     // linear-interpolated input from fragment-shader\n\nvoid main(void) {\n  gl_FragColor = vColor;\n}";
  };

  if (ªF === typeof define && define.amd) {
    define(function() {
      return Main;
    });
  } else if (ªO === typeof module && module && module.exports) {
    module.exports = Main;
  } else {
    ªW[ªC] = Main;
  }

  mat4 = {};

  mat4.multiply = function(a, b) {
    var a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33, b0, b1, b2, b3, out;
    out = new Float32Array(16);
    a00 = a[0];
    a01 = a[1];
    a02 = a[2];
    a03 = a[3];
    a10 = a[4];
    a11 = a[5];
    a12 = a[6];
    a13 = a[7];
    a20 = a[8];
    a21 = a[9];
    a22 = a[10];
    a23 = a[11];
    a30 = a[12];
    a31 = a[13];
    a32 = a[14];
    a33 = a[15];
    b0 = b[0];
    b1 = b[1];
    b2 = b[2];
    b3 = b[3];
    out[0] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[1] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[2] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[3] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    b0 = b[4];
    b1 = b[5];
    b2 = b[6];
    b3 = b[7];
    out[4] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[5] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[6] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[7] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    b0 = b[8];
    b1 = b[9];
    b2 = b[10];
    b3 = b[11];
    out[8] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[9] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[10] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[11] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    b0 = b[12];
    b1 = b[13];
    b2 = b[14];
    b3 = b[15];
    out[12] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
    out[13] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
    out[14] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
    out[15] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
    return out;
  };

  mat4.perspective = function(fovy, aspect, near, far) {
    var f, nf, out;
    f = 1.0 / Math.tan(fovy / 2);
    nf = 1 / (near - far);
    out = new Float32Array(16);
    out[0] = f / aspect;
    out[1] = 0;
    out[2] = 0;
    out[3] = 0;
    out[4] = 0;
    out[5] = f;
    out[6] = 0;
    out[7] = 0;
    out[8] = 0;
    out[9] = 0;
    out[10] = (far + near) * nf;
    out[11] = -1;
    out[12] = 0;
    out[13] = 0;
    out[14] = (2 * far * near) * nf;
    out[15] = 0;
    return out;
  };

  mat4.rotateX = function(a, rad) {
    var a10, a11, a12, a13, a20, a21, a22, a23, c, s;
    s = Math.sin(rad);
    c = Math.cos(rad);
    a10 = a[4];
    a11 = a[5];
    a12 = a[6];
    a13 = a[7];
    a20 = a[8];
    a21 = a[9];
    a22 = a[10];
    a23 = a[11];
    a[4] = a10 * c + a20 * s;
    a[5] = a11 * c + a21 * s;
    a[6] = a12 * c + a22 * s;
    a[7] = a13 * c + a23 * s;
    a[8] = a20 * c - a10 * s;
    a[9] = a21 * c - a11 * s;
    a[10] = a22 * c - a12 * s;
    a[11] = a23 * c - a13 * s;
    return a;
  };

  mat4.rotateY = function(a, rad) {
    var a00, a01, a02, a03, a20, a21, a22, a23, c, s;
    s = Math.sin(rad);
    c = Math.cos(rad);
    a00 = a[0];
    a01 = a[1];
    a02 = a[2];
    a03 = a[3];
    a20 = a[8];
    a21 = a[9];
    a22 = a[10];
    a23 = a[11];
    a[0] = a00 * c - a20 * s;
    a[1] = a01 * c - a21 * s;
    a[2] = a02 * c - a22 * s;
    a[3] = a03 * c - a23 * s;
    a[8] = a00 * s + a20 * c;
    a[9] = a01 * s + a21 * c;
    a[10] = a02 * s + a22 * c;
    a[11] = a03 * s + a23 * c;
    return a;
  };

  mat4.rotateZ = function(a, rad) {
    var a00, a01, a02, a03, a10, a11, a12, a13, c, s;
    s = Math.sin(rad);
    c = Math.cos(rad);
    a00 = a[0];
    a01 = a[1];
    a02 = a[2];
    a03 = a[3];
    a10 = a[4];
    a11 = a[5];
    a12 = a[6];
    a13 = a[7];
    a[0] = a00 * c + a10 * s;
    a[1] = a01 * c + a11 * s;
    a[2] = a02 * c + a12 * s;
    a[3] = a03 * c + a13 * s;
    a[4] = a10 * c - a00 * s;
    a[5] = a11 * c - a01 * s;
    a[6] = a12 * c - a02 * s;
    a[7] = a13 * c - a03 * s;
    return a;
  };

  mat4.translate = function(a, x, y, z) {
    a[12] = a[0] * x + a[4] * y + a[8] * z + a[12];
    a[13] = a[1] * x + a[5] * y + a[9] * z + a[13];
    a[14] = a[2] * x + a[6] * y + a[10] * z + a[14];
    a[15] = a[3] * x + a[7] * y + a[11] * z + a[15];
    return a;
  };

  mat4.ortho = function(left, right, bottom, top, near, far) {
    var bt, lr, nf, out;
    lr = 1 / (left - right);
    bt = 1 / (bottom - top);
    nf = 1 / (near - far);
    out = new Float32Array(16);
    out[0] = -2 * lr;
    out[1] = 0;
    out[2] = 0;
    out[3] = 0;
    out[4] = 0;
    out[5] = -2 * bt;
    out[6] = 0;
    out[7] = 0;
    out[8] = 0;
    out[9] = 0;
    out[10] = 2 * nf;
    out[11] = 0;
    out[12] = (left + right) * lr;
    out[13] = (top + bottom) * bt;
    out[14] = (far + near) * nf;
    out[15] = 1;
    return out;
  };

  mat4.makeTranslation = function(tx, ty, tz) {
    return new Float32Array([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, tx, ty, tz, 1]);
  };

  mat4.makeXRotation = function(angleInRadians) {
    var c, s;
    c = Math.cos(angleInRadians);
    s = Math.sin(angleInRadians);
    return new Float32Array([1, 0, 0, 0, 0, c, s, 0, 0, -s, c, 0, 0, 0, 0, 1]);
  };

  mat4.makeYRotation = function(angleInRadians) {
    var c, s;
    c = Math.cos(angleInRadians);
    s = Math.sin(angleInRadians);
    return new Float32Array([c, 0, -s, 0, 0, 1, 0, 0, s, 0, c, 0, 0, 0, 0, 1]);
  };

  mat4.makeZRotation = function(angleInRadians) {
    var c, s;
    c = Math.cos(angleInRadians);
    s = Math.sin(angleInRadians);
    return [c, s, 0, 0, -s, c, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
  };

  mat4.makeScale = function(sx, sy) {
    return new Float32Array([sx, 0, 0, 0, 0, sy, 0, 0, 0, 0, sz, 0, 0, 0, 0, 1]);
  };

  mat4.makeProjection = function(width, height, depth) {
    return new Float32Array([2 / width, 0, 0, 0, 0, -2 / height, 0, 0, 0, 0, 2 / depth, 0, -1, 1, 0, 1]);
  };

}).call(this);
