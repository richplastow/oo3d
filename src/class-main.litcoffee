Main
====

@todo describe


#### The main class for Oo3d

    class Main
      C: ªC
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->

Record all config as instance properties. 

        @[k] = v for k,v of config




Properties
----------


#### `$main <HTMLCanvasElement>`
Xx. @todo describe

        @$main = config.$main or null
        if @$main and ('htmlcanvaselement' != ªtype @$main) then throw Error """
          If set, config.$main must be HTMLCanvasElement not #{ªtype @$main}"""


#### `gl <Xx>`
WebGL context, provided by the main `<CANVAS>` element’s `getContext()` method, 
after `initWebGL()` has been run. 

        @gl = null




Init
----

Initialize the instance, if `@$main` has been defined. 

        if @$main
          @initWebGL()
          if @gl
            @initCanvas()




Methods
-------


#### `initWebGL()`
Try to grab the standard WebGL context. If it fails, fallback to experimental. 
If that fails, show an error alert. [From MDN’s article.](https://goo.gl/DYPEVk)

      initWebGL: ->
        try
          @gl =
            @$main.getContext 'webgl' or @$main.getContext 'experimental-webgl'
        catch
        if ! @gl
          alert "Unable to initialize WebGL. Your browser may not support it."




#### `initCanvas()`
Set the canvas context background to black, and set various WebGL parameters.  
[From MDN’s article, again.](https://goo.gl/DYPEVk)  
1. Set clear-color to opaque #6668B4
2. Enable depth testing
3. Near things obscure far things
4. Clear the color as well as the depth buffer

      initCanvas: ->
        @gl.clearColor 0.3984375, 0.40625, 0.703125, 1.0
        @gl.enable @gl.DEPTH_TEST
        @gl.depthFunc @gl.LEQUAL
        @gl.clear @gl.COLOR_BUFFER_BIT | @gl.DEPTH_BUFFER_BIT




Functions
---------


#### `xx()`
- `xx <xx>`  Xx 

Xx. @todo describe

    xx = (xx) ->



