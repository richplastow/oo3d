// Generated by CoffeeScript 1.9.2

/*! Oo3d 0.0.4 //// MIT Licence //// http://oo3d.richplastow.com/ */

(function() {
  var Main, Tudor, getFragmentSource, getVertexSource, tudor, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªW, ªX, ªex, ªhas, ªredefine, ªtype, ªuid,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ªC = 'Oo3d';

  ªV = '0.0.4';

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
      this.vpAttribute = null;
      this.shaderProgram = null;
      this.buffer = null;
      if (this.$main) {
        this.initWebGL();
        if (this.gl) {
          this.initCanvas();
          this.initShaders();
          this.initShaderProgram();
          this.initBuffer();
        }
      }
    }

    Main.prototype.initWebGL = function() {
      try {
        this.gl = this.$main.getContext('webgl' || this.$main.getContext('experimental-webgl'));
      } catch (_error) {

      }
      if (!this.gl) {
        return alert("Unable to initialize WebGL. Your browser may not support it.");
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
      this.vpAttribute = this.gl.getAttribLocation(this.shaderProgram, 'aVertexPosition');
      return this.gl.enableVertexAttribArray(this.vpAttribute);
    };

    Main.prototype.initBuffer = function() {
      var vertices;
      vertices = new Float32Array([0.0, 1.0, 0.0, -1.0, -1.0, 0.0, 0.0, -1.0, 0.0]);
      this.buffer = this.gl.createBuffer();
      this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffer);
      return this.gl.bufferData(this.gl.ARRAY_BUFFER, vertices, this.gl.STATIC_DRAW);
    };

    Main.prototype.render = function() {
      if (!this.gl) {
        throw Error("The WebGL rendering context is " + (ªtype(this.gl)));
      }
      this.gl.vertexAttribPointer(this.vpAttribute, 3, this.gl.FLOAT, false, 0, 0);
      return this.gl.drawArrays(this.gl.TRIANGLES, 0, 3);
    };

    return Main;

  })();

  getFragmentSource = function() {
    return "void main(void) {\n  gl_FragColor = vec4(0,1,0,0.7); // green\n}";
  };

  getVertexSource = function() {
    return "attribute vec2 aVertexPosition;\n\nvoid main() {\n  gl_Position = vec4(aVertexPosition, 0, 1);\n}";
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

  Tudor = (function() {
    Tudor.prototype.I = 'Tudor';

    Tudor.prototype.toString = function() {
      return "[object " + I + "]";
    };

    Tudor.prototype.articles = [];

    function Tudor(opt) {
      this.opt = opt != null ? opt : {};
      this["do"] = bind(this["do"], this);
      switch (this.opt.format) {
        case 'html':
          this.pageHead = function(summary) {
            return "<style>\n  body     { font-family: sans-serif; }\n  a        { outline: 0; }\n  b        { display: inline-block; width: .7em }\n\n  b.pass              { color: #393 }\n  b.fail              { color: #bbb }\n  article.fail b.pass { color: #bbb }\n  section.fail b.pass { color: #bbb }\n\n  pre      { padding: .5em; margin: .2em 0; border-radius: 4px; }\n  pre.fn   { background-color: #fde }\n  pre.pass { background-color: #cfc }\n  pre.fail { background-color: #d8e0e8 }\n\n  article  { margin-bottom: .5rem }\n  article h2 { padding-left:.5rem; margin:0; font-weight:normal }\n  article.pass { border-left: 5px solid #9c9 }\n  article.fail { border-left: 5px solid #9bf }\n  article.fail h2 { margin-bottom: .5rem }\n  article.pass >div { display: none }\n\n  section  { margin-bottom: .5rem }\n  section h3   { padding-left: .5rem; margin: 0; }\n  section.pass { border-left: 3px solid #9c9 }\n  section.fail { border-left: 3px solid #9bf }\n  section.fail h3 { margin-bottom: .5rem }\n  section.pass >div { display: none }\n\n  article.fail section.pass { border-left-color: #ccc }\n\n  div      { padding-left: .5em; }\n  div.fail { border-left: 3px solid #9bf; font-size: .8rem }\n  div h4   { margin: 0 }\n  div h4 { font: normal .8rem/1.2rem monaco, monospace }\n  div.fail, div.fail h4 { margin: .5rem 0 }\n\n</style>\n<h4><a href=\"#end\" id=\"top\">\u2b07</a>  " + summary + "</h4>";
          };
          this.pageFoot = function(summary) {
            return "<h4><a href=\"#top\" id=\"end\">\u2b06</a>  " + summary + "</h4>\n<script>\n  document.title='" + (summary.replace(/<\/?[^>]+>/g, '')) + "';\n</script>";
          };
          this.articleHead = function(heading, fail) {
            return ("<article class=\"" + (fail ? 'fail' : 'pass') + "\">") + ("<h2>" + (fail ? this.cross : this.tick) + heading + "</h2><div>");
          };
          this.articleFoot = '</div></article>';
          this.sectionHead = function(heading, fail) {
            return ("<section class=\"" + (fail ? 'fail' : 'pass') + "\">") + ("<h3>" + (fail ? this.cross : this.tick) + heading + "</h3><div>");
          };
          this.sectionFoot = '</div></section>';
          this.jobFormat = function(heading, result) {
            return ("<div class=\"" + (result ? 'fail' : 'pass') + "\">") + ("<h4>" + (result ? this.cross : this.tick) + heading + "</h4>") + ("" + (result ? this.formatError(result) : '')) + "</div>";
          };
          this.tick = '<b class="pass">\u2713</b> ';
          this.cross = '<b class="fail">\u2718</b> ';
          break;
        default:
          this.pageHead = function(summary) {
            return "" + summary;
          };
          this.pageFoot = function(summary) {
            return "\n" + summary;
          };
          this.articleHead = function(heading, fail) {
            return "\n" + (fail ? this.cross : this.tick) + " " + heading + "\n===" + (new Array(heading.length).join('=')) + "\n";
          };
          this.articleFoot = '';
          this.sectionHead = function(heading, fail) {
            return "\n" + (fail ? this.cross : this.tick) + " " + heading + "\n---" + (new Array(heading.length).join('-')) + "\n";
          };
          this.sectionFoot = '';
          this.jobFormat = function(heading, result) {
            return ((result ? this.cross : this.tick) + " " + heading) + ("" + (result ? '\n' + this.formatError(result) : ''));
          };
          this.jobFoot = '';
          this.tick = '\u2713';
          this.cross = '\u2718';
      }
    }

    Tudor.prototype.add = function(lines) {
      var article, i, line, runner, section;
      article = {
        sections: []
      };
      runner = null;
      section = null;
      if (ªA !== ªtype(lines)) {
        throw new Error("`lines` isn’t an array");
      }
      if (0 === lines.length) {
        throw new Error("`lines` has no elements");
      }
      if (ªS !== ªtype(lines[0])) {
        throw new Error("`lines[0]` isn’t a string");
      }
      article.heading = lines.shift();
      i = 0;
      while (i < lines.length) {
        line = lines[i];
        switch (ªtype(line)) {
          case ªO:
            if (!line.runner) {
              throw new Error("Errant object");
            }
            runner = line.runner;
            break;
          case ªF:
            section.jobs.push(line);
            break;
          case ªS:
            if (this.isAssertion(lines[i + 1], lines[i + 2])) {
              if (!section) {
                throw new Error("Cannot add an assertion here");
              }
              section.jobs.push([runner, line, lines[++i], lines[++i]]);
            } else {
              section = {
                heading: line,
                jobs: []
              };
              article.sections.push(section);
            }
        }
        i++;
      }
      return this.articles.push(article);
    };

    Tudor.prototype["do"] = function() {
      var actual, art, artFail, artPass, article, e, error, expect, heading, j, job, l, len, len1, len2, m, mock, pge, pgeFail, pgePass, ref, ref1, ref2, result, runner, sec, secFail, secPass, section, summary;
      pge = [];
      mock = null;
      pgePass = pgeFail = 0;
      ref = this.articles;
      for (j = 0, len = ref.length; j < len; j++) {
        article = ref[j];
        art = [];
        artPass = artFail = 0;
        ref1 = article.sections;
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          section = ref1[l];
          sec = [];
          secPass = secFail = 0;
          ref2 = section.jobs;
          for (m = 0, len2 = ref2.length; m < len2; m++) {
            job = ref2[m];
            switch (ªtype(job)) {
              case ªF:
                try {
                  mock = job.apply(this, mock);
                } catch (_error) {
                  e = _error;
                  error = e.message;
                }
                if (error) {
                  sec.push(this.formatMockModifierError(job, error));
                }
                break;
              case ªA:
                runner = job[0], heading = job[1], expect = job[2], actual = job[3];
                result = runner(expect, actual, mock);
                if (!result) {
                  sec.push(this.jobFormat("" + (this.sanitize(heading))));
                  pgePass++;
                  artPass++;
                  secPass++;
                } else {
                  sec.push(this.jobFormat("" + (this.sanitize(heading)), result));
                  pgeFail++;
                  artFail++;
                  secFail++;
                }
            }
          }
          sec.unshift(this.sectionHead("" + (this.sanitize(section.heading)), secFail));
          sec.push(this.sectionFoot);
          art = art.concat(sec);
        }
        art.unshift(this.articleHead("" + (this.sanitize(article.heading)), artFail));
        art.push(this.articleFoot);
        pge = pge.concat(art);
        summary = pgeFail ? this.cross + " FAILED " + pgeFail + "/" + (pgePass + pgeFail) : this.tick + " Passed " + pgePass + "/" + (pgePass + pgeFail);
      }
      pge.unshift(this.pageHead(summary));
      pge.push(this.pageFoot(summary));
      return pge.join('\n');
    };

    Tudor.prototype.formatError = function(result) {
      switch (result.length + "-" + this.opt.format) {
        case '2-html':
          return result[0] + "\n<pre class=\"fail\">" + (this.sanitize(result[1].message)) + "</pre>";
        case '2-plain':
          return result[0] + "\n" + (this.sanitize(result[1].message));
        case '3-html':
          return "<pre class=\"fail\">" + (this.sanitize(this.reveal(result[0]))) + "</pre>\n..." + result[1] + "...\n<pre class=\"pass\">" + (this.sanitize(this.reveal(result[2]))) + "</pre>";
        case '3-plain':
          return (this.sanitize(this.reveal(result[0]))) + "\n..." + result[1] + "...\n" + (this.sanitize(this.reveal(result[2])));
        case '4-html':
          return "<pre class=\"fail\">" + (this.sanitize(this.reveal(result[0]))) + " (" + (ªtype(result[0])) + ")</pre>\n..." + result[1] + "...\n<pre class=\"pass\">" + (this.sanitize(this.reveal(result[2]))) + " (" + (ªtype(result[2])) + ")</pre>";
        case '4-plain':
          return (this.sanitize(this.reveal(result[0]))) + " (" + (ªtype(result[0])) + ")\n..." + result[1] + "...\n" + (this.sanitize(this.reveal(result[2]))) + " (" + (ªtype(result[2])) + ")";
        default:
          throw new Error("Cannot process '" + result.length + "-" + this.opt.format + "'");
      }
    };

    Tudor.prototype.formatMockModifierError = function(fn, error) {
      switch (this.opt.format) {
        case 'html':
          return "<pre class=\"fn\">" + (this.sanitize(fn + '')) + "</pre>\n...encountered an exception:\n<pre class=\"fail\">" + (this.sanitize(error)) + "</pre>";
        default:
          return (this.sanitize(fn + '')) + "\n...encountered an exception:\n" + (this.sanitize(error));
      }
    };

    Tudor.prototype.reveal = function(value) {
      return value != null ? value.toString().replace(/^\s+|\s+$/g, function(match) {
        return '\u00b7' + (new Array(match.length)).join('\u00b7');
      }) : void 0;
    };

    Tudor.prototype.sanitize = function(value) {
      switch (this.opt.format) {
        case 'html':
          return value != null ? value.toString().replace(/</g, '&lt;') : void 0;
        default:
          return value;
      }
    };

    Tudor.prototype["throw"] = {
      runner: function(expect, actual, mock) {
        var e, error;
        error = false;
        try {
          actual.apply(this, mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (!error) {
          return [
            'No exception thrown, expected', {
              message: expect
            }
          ];
        } else if (expect !== error.message) {
          return [error.message, 'was thrown, but expected', expect];
        }
      }
    };

    Tudor.prototype.equal = {
      runner: function(expect, actual, mock) {
        var e, error, result;
        error = false;
        try {
          result = actual.apply(this, mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (error) {
          return ['Unexpected exception', error];
        } else if (expect !== result) {
          if (result + '' === expect + '') {
            return [result, 'was returned, but expected', expect, true];
          } else {
            return [result, 'was returned, but expected', expect];
          }
        }
      }
    };

    Tudor.prototype.is = {
      runner: function(expect, actual, mock) {
        var e, error, result;
        error = false;
        try {
          result = actual.apply(this, mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (error) {
          return ['Unexpected exception', error];
        } else if (expect !== ªtype(result)) {
          return ["type " + (ªtype(result)), 'was returned, but expected', "type " + expect];
        }
      }
    };

    Tudor.prototype.match = {
      runner: function(expect, actual, mock) {
        var e, error, result;
        error = false;
        try {
          result = actual.apply(this, mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (error) {
          return ['Unexpected exception', error];
        } else if (ªF !== typeof expect.test) {
          return [
            '`test()` is not a function', {
              message: expect
            }
          ];
        } else if (!expect.test('' + result)) {
          return ['' + result, 'failed test', expect];
        }
      }
    };

    Tudor.prototype.isAssertion = function(line1, line2) {
      if (ªF !== ªtype(line2)) {
        return false;
      }
      if ((ªO === ªtype(line1)) && ªF === ªtype(line1.runner)) {
        return false;
      }
      return true;
    };

    return Tudor;

  })();

  tudor = new Tudor({
    format: ªO === typeof window ? 'html' : 'plain'
  });

  Main.runTest = tudor["do"];

  tudor.add([
    "01 Oo3d Constructor Usage", tudor.is, "The class and instance are expected types", "The class is a function", ªF, function() {
      return Main;
    }, "`new` returns as object", ªO, function() {
      return new Main;
    }, "Config exceptions", tudor["throw"], "`config.$main` must not be a number", "If set, config.$main must be HTMLCanvasElement not number", function() {
      return new Main({
        $main: 123
      });
    }
  ]);

}).call(this);
