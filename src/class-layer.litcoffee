Layer
=====


#### Assigns a blending mode and opacity to a Renderer instance

    class Layer
      C: 'Layer'
      toString: -> "[object #{@C}]"

      constructor: (@main, config={}) ->
        if ªO != ªtype config then throw TypeError "
          `config` must be object not #{ªtype config}"




Properties
----------


#### `main <Oo3d>`
Xx. @todo describe

        if ªO != ªtype @main then throw TypeError "
          `main` must be object not #{ªtype @main}"
        if '[object Oo3d]' != ''+@main then throw TypeError "
          `main` must be [object Oo3d] not #{@main}"


#### `renderer <Renderer>`
This Layer’s Renderer, referenced from the main instance’s `renderers` array. 

        if ªN != ªtype config.rendererI then throw TypeError "
          config.rendererI must be number not #{ªtype config.rendererI}"
        @renderer = @main.renderers[config.rendererI] or throw RangeError "
          No such index #{config.rendererI} in main.renderers"




Methods
-------


#### `render()`
Xx. @todo describe

      render: ->

        ª 'layer setup in here!'
        @renderer.render()




