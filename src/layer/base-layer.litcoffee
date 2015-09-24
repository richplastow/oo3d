Layer
=====


#### The base class for all Layer child-classes, like @todo which?

- Applies blending and cropping to a list of Renderers
- The `main` instance renders each Layer in its `layers` array
- A Layer can appear more than once in `main.layers`
- All Layers are stored in the `main._all` array, whether they’re used or not

@todo describe

    class Layer
      C: 'Layer'
      toString: -> '[object Layer]'




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Layer’s index in `main._all`
- `config <object>`  (optional) configuration and options

@todo describe

      constructor: (@main, @index, config={}) ->
        M = "/oo3d/src/layer/base-layer.litcoffee
          Layer##{+@index}()\n  "
        if ªO != ªtype config then throw TypeError "
          #{M}Optional `config` is #{ªtype config} not object"




Properties
----------


#### `main <Oo3d>`
A reference to the main Oo3d instance which created this Layer. 

        if ªO != typeof @main then throw TypeError "
          #{M}`main` is #{ªtype @main} not object"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          #{M}`main` is '#{@main}' not '[object Oo3d]'"


#### `index <integer>`
This Layer’s index in `main._all`. 

        if ªN != typeof @index then throw TypeError "
          #{M}`index` is #{ªtype @index} not number"
        if ªMAX < @index or @index % 1 or 0 > @index then throw RangeError "
          #{M}`index` is #{@index} not 0 or a positive integer below 2^53"


#### `renderers <array of Renderers>`
This Layer’s Renderers, referenced from the `main` instance’s `_all` array, in 
the order they will be rendered. 

        tRIs = ªtype config.rendererIs
        if ªU == tRIs then @renderers = []
        else if ªA != tRIs then throw TypeError "
          #{M}`config.rendererIs` is #{tRIs} not array"
        else @renderers = for index,i in config.rendererIs
          if ªN != typeof index then throw TypeError "
            #{M}`config.rendererIs[#{i}]` is #{ªtype index} not number"
          rd = @main._all[index]
          if ! rd or ! (rd instanceof Renderer) then throw TypeError "
            #{M}`config.rendererIs[#{i}]` refs #{rd.C} at `main._all[#{index}]`"
          rd


#### `scissor <array of numbers|null>`
A crop box. If null, no cropping is done. 

        tSc = ªtype config.scissor
        if ªU == tSc or ªX == tSc then @scissor = null
        else if ªA != tSc then throw TypeError "
          #{M}`config.scissor` is #{tSc} not array|null"
        else if 4 != config.scissor.length then throw RangeError "
          #{M}`config.scissor.length` must be 4 not #{config.scissor.length}"
        else
          for num,i in config.scissor
            if ªN != typeof num then throw TypeError "
              #{M}`config.scissor[#{i}]` is #{ªtype num} not number"
            if 0 > num or 1 < num then throw RangeError "
              #{M}`config.scissor[#{i}]` is out-of-range #{num}"
        @scissor = config.scissor




#### `xx <xx>`
@todo describe. 




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




