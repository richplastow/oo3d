// Generated by CoffeeScript 1.9.2

/*! Oo3d 0.0.6 //// MIT Licence //// http://oo3d.richplastow.com/ */

(function() {
  var Main, getFragmentSource, getVertexSource, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªW, ªX, ªex, ªhas, ªredefine, ªtype, ªuid;

  ªC = 'Oo3d';

  ªV = '0.0.6';

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
      this.fragmentShader = null;
      this.vertexShader = null;
      this.aVertexPosRef = null;
      this.uColorRef = null;
      this.shaderProgram = null;
      this.buffers = [];
      if (this.$main) {
        this.initWebGL();
        if (this.gl) {
          this.initCanvas();
          this.initShaders();
          this.initShaderProgram();
        }
      }
    }

    Main.prototype.initWebGL = function() {
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
      return this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
    };

    Main.prototype.initShaders = function() {
      this.fragmentShader = this.gl.createShader(this.gl.FRAGMENT_SHADER);
      this.vertexShader = this.gl.createShader(this.gl.VERTEX_SHADER);
      this.gl.shaderSource(this.fragmentShader, getFragmentSource());
      this.gl.shaderSource(this.vertexShader, getVertexSource());
      this.gl.compileShader(this.fragmentShader);
      this.gl.compileShader(this.vertexShader);
      if (!this.gl.getShaderParameter(this.fragmentShader, this.gl.COMPILE_STATUS)) {
        throw Error("@fragmentShader did not compile successfully");
      }
      if (!this.gl.getShaderParameter(this.vertexShader, this.gl.COMPILE_STATUS)) {
        throw Error("@vertexShader did not compile successfully");
      }
    };

    Main.prototype.initShaderProgram = function() {
      this.shaderProgram = this.gl.createProgram();
      this.gl.attachShader(this.shaderProgram, this.fragmentShader);
      this.gl.attachShader(this.shaderProgram, this.vertexShader);
      this.gl.linkProgram(this.shaderProgram);
      if (!this.gl.getProgramParameter(this.shaderProgram, this.gl.LINK_STATUS)) {
        throw Error("@shaderProgram did not link successfully");
      }
      this.gl.useProgram(this.shaderProgram);
      this.aVertexPosRef = this.gl.getAttribLocation(this.shaderProgram, 'aVertexPos');
      return this.gl.enableVertexAttribArray(this.aVertexPosRef);
    };

    Main.prototype.initBuffer = function(vertices) {
      this.buffers.push(this.gl.createBuffer());
      this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[0]);
      return this.gl.bufferData(this.gl.ARRAY_BUFFER, new Float32Array(vertices), this.gl.STATIC_DRAW);
    };

    Main.prototype.addBuffer = function(vertices) {
      var index;
      index = this.buffers.length;
      this.buffers.push(this.gl.createBuffer());
      this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[index]);
      this.gl.bufferData(this.gl.ARRAY_BUFFER, new Float32Array(vertices), this.gl.STATIC_DRAW);
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
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers[index]);
        this.gl.vertexAttribPointer(this.aVertexPosRef, 3, this.gl.FLOAT, false, 0, 0);
        results.push(this.gl.drawArrays(this.gl.TRIANGLES, 0, 3));
      }
      return results;
    };

    return Main;

  })();

  getVertexSource = function() {
    return "attribute vec2 aVertexPos;\n\nvarying vec4 vColor;     // declare `vColor`\n\nvoid main() {\n  gl_Position = vec4(aVertexPos, 0, 1);\n  vColor = gl_Position * vec4(4,4,4,4); // send to the fragment shader\n}";
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
