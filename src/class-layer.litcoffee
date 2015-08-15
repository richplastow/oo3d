Layer
=====


#### Applies blending and cropping to a list of Renderers

    class Layer
      C: 'Layer'
      toString: -> "[object #{@C}]"

      constructor: (@main, config={}) ->
        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Layer. 

        if ªO != ªtype @main then throw TypeError "
          `main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          `main` must be [object Oo3d] not #{@main}"


#### `renderers <array of Renderers>`
This Layer’s Renderers, referenced from the main instance’s `renderers` array 
in the order they will be rendered. 

        if ! config.rendererIs then @renderers = []
        else if 'uint16array' != ªtype config.rendererIs then throw TypeError "
          If set, config.rendererIs must be Uint16Array not #{ªtype config.rendererIs}"
        else @renderers = (@main.renderers[i] or throw RangeError "
          No such index #{i} in main.renderers" for i in config.rendererIs)


#### `scissor <Float32Array|null>`
A crop box. If null, no cropping is done. 

        @scissor = config.scissor
        if ! @scissor then @scissor = null
        else if 'float32array' != ªtype @scissor then throw TypeError "
          If set, config.scissor must be Float32Array not #{ªtype @scissor}"
        else if 4 != @scissor.length then throw RangeError "
          If set, config.scissor.length must be 4 not #{@scissor.length}"
        else for float in @scissor
          if 0 > float or 1 < float then throw RangeError "
            config.scissor contains out-of-range #{float}"




Methods
-------


#### `render()`
Xx. @todo describe

      render: ->

Apply Layer crop. 

        if @scissor
          @main.gl.scissor(
            @scissor[0] * @main.$main.width,
            @scissor[1] * @main.$main.height,
            @scissor[2] * @main.$main.width,
            @scissor[3] * @main.$main.height
          )

Apply Layer blend. 

        #@todo

Render each renderer. 

        renderer.render() for renderer in @renderers




