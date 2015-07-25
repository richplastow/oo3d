// Generated by CoffeeScript 1.9.2

/*! Oo3d 0.0.8 //// MIT Licence //// http://oo3d.richplastow.com/ */

(function() {
  var Buffer, Main, getFragmentSource, getVertexSource, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªW, ªX, ªex, ªhas, ªredefine, ªtype, ªuid;

  ªC = 'Oo3d';

  ªV = '0.0.8';

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
      }
      this.colors = this.gl.createBuffer();
      this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.colors);
      this.gl.bufferData(this.gl.ARRAY_BUFFER, new Float32Array(config.colors), this.gl.STATIC_DRAW);
    }

    return Buffer;

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
      this.uMatTransformLoc = null;
      this.uMatProjectionLoc = null;
      this.buffers = [];
      if (this.$main) {
        this.initGL();
        if (this.gl) {
          this.initCanvas();
          this.initShaders();
          this.initProgram();
          this.initProjection();
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
      this.uMatTransformLoc = this.gl.getUniformLocation(this.program, 'uMatTransform');
      this.uMatProjectionLoc = this.gl.getUniformLocation(this.program, 'uMatProjection');
      return this.gl.uniformMatrix4fv(this.uMatTransformLoc, false, new Float32Array([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, -10, 0, 0, 0, 1]));
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

    Main.prototype.initProjection = function() {
      var a, aspectRatio, b, bottom, c, d, farPlane, fieldOfView, left, nearPlane, right, top, x, y;
      fieldOfView = 30.0;
      aspectRatio = this.$main.width / this.$main.height;
      nearPlane = 0.1;
      farPlane = 10000.0;
      top = nearPlane * Math.tan(fieldOfView * Math.PI / 360.0);
      bottom = -top;
      right = top * aspectRatio;
      left = -right;
      a = (right + left) / (right - left);
      b = (top + bottom) / (top - bottom);
      c = (farPlane + nearPlane) / (farPlane - nearPlane);
      d = (2 * farPlane * nearPlane) / (farPlane - nearPlane);
      x = (2 * nearPlane) / (right - left);
      y = (2 * nearPlane) / (top - bottom);
      return this.gl.uniformMatrix4fv(this.uMatProjectionLoc, false, new Float32Array([x, 0, a, 0, 0, y, b, 0, 0, 0, c, d, 0, 0, -1, 0]));
    };

    Main.prototype.addBuffer = function(config) {
      var index;
      index = this.buffers.length;
      this.buffers[index] = new Buffer(config, this.gl);
      return index;
    };

    Main.prototype.render = function() {
      var index, results;
      if (!this.gl) {
        throw Error("The WebGL rendering context is " + (ªtype(this.gl)));
      }
      index = this.buffers.length;
      results = [];
      while (index--) {
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[index].positions);
        this.gl.vertexAttribPointer(this.aVtxPositionLoc, 3, this.gl.FLOAT, false, 0, 0);
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[index].colors);
        this.gl.vertexAttribPointer(this.aVtxColorLoc, 4, this.gl.FLOAT, false, 0, 0);
        this.gl.drawArrays(this.gl.TRIANGLES, 0, 3);
        results.push(this.gl.flush());
      }
      return results;
    };

    return Main;

  })();

  getVertexSource = function() {
    return "attribute vec3 aVtxPosition;\nattribute vec4 aVtxColor;\n\nuniform mat4 uMatTransform;\nuniform mat4 uMatProjection;\n\nvarying vec4 vColor; // declare `vColor`\n\nvoid main() {\n\n  // Multiply the position by the transformation and projection matrices\n  gl_Position = vec4(aVtxPosition, 1) * uMatTransform * uMatProjection;\n\n  // Convert from clipspace to colorspace, and send to the fragment-shader\n  // Clipspace goes -1.0 to +1.0\n  // Colorspace goes from 0.0 to 1.0\n  // vColor = gl_Position * 0.5 + 0.5; //vec4(4,4,4,4);\n\n  // Just pass the vertex-color attribute unchanged to the fragment-shader\n  vColor = aVtxColor;\n}";
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

}).call(this);
