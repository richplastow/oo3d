Renderer
========


#### The base class for all renderers

    class RendererXXOLD
      C: 'Renderer'
      toString: -> "[object #{@C}]"

      constructor: (@main, config={}) ->




Properties
----------


#### `main <Oo3d>`
Xx. @todo describe

        if ªO != ªtype @main or 'oo3d' != ''+@main then throw Error """
          `main` must be Oo3d not #{ªtype @main}"""


#### `scissor <Float32Array|null>`
A crop box. If null, no cropping is done. 

        @scissor = config.scissor
        if ! @scissor then @scissor = null
        else if 'float32array' != ªtype @scissor then throw TypeError """
          If set, config.scissor must be Float32Array not #{ªtype @scissor}"""
        else if 4 != @scissor.length then throw RangeError """
          If set, config.scissor.length must be 4 not #{@scissor.length}"""
        else for float in @scissor
          if 0 > float or 1 < float then throw RangeError """
            config.scissor contains out-of-range #{float}"""



