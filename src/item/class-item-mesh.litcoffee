Item.Mesh
=========


@todo describe




#### `constructor()`
- `main <Main>`      a reference to the main Oo3d instance
- `index <integer>`  this Item.Mesh’s index in `main._all`
- `config <object>`  (optional) configuration and options

    class Item.Mesh extends Item
      C: 'Item.Mesh'
      toString: -> "[object Item.Mesh]"


      constructor: (main, index, config={}) ->
        M = "/oo3d/src/item/class-item-mesh.litcoffee
          Item.Mesh##{+index}()\n  "




Inherit Properties
------------------


        super main, index, config

#### `main <Oo3d>` (inherited)
#### `index <integer>` (inherited)
#### `oT <string>` (inherited)
#### `mT <Float32Array>` (inherited)
#### `rX, rY, rZ <number>` (inherited)
#### `sX, sY, sZ <number>` (inherited)
#### `tX, tY, tZ <number>` (inherited)




Instantiation Arguments
-----------------------


#### `color <Float32Array>`
A color which can act as an ID. Useful for picking. 

        @color = pick.indexToColor @index # defined in /src/pick.coffee
        #ª @index, (Math.round(channel*255) for channel in @color)


#### `positionBuffer <Buffer.Position>`
Xx. @todo describe

        @positionBuffer = @main._all[config.positionI or 0]
        if ! @positionBuffer then throw Error "
          #{M}`config.positionI` #{config.positionI} does not exist"


#### `colorBuffer <Buffer.Color>`
Xx. @todo describe  
@todo make optional

        @colorBuffer = @main._all[config.colorI or 1]
        if ! @colorBuffer then throw Error "
          #{M}`config.colorI` #{config.colorI} does not exist"


#### `count <integer>`
Xx. @todo describe

        if @positionBuffer.count != @colorBuffer.count then throw Error "
          #{M}`config.positionI` mismatches config.colorI"
        @count = @positionBuffer.count


#### `renderMode <string>`
'POINTS', 'LINE_STRIP', 'TRIANGLES', etc. Equates to an integer in the `gl` 
object, eg `gl.TRIANGLES` is `4`. This integer becomes the `mode` argument 
passed to `gl.drawArrays()` when this Item is rendered.  
@todo override at the level of a Layer, and maybe at other levels too

        @renderMode = config.renderMode or 'TRIANGLES' # default if falsey
        if ! Item.Mesh.validRenderMode[@renderMode] then throw Error "
          #{M}`config.renderMode` #{@renderMode} is not recognised by WebGL"


#### `sBlend and dBlend <integer|null>`
Xx. @todo describe

        if ! config.blend # any falsey value, or leave undefined
          @sBlend = null
          @dBlend = null
        else if ªA != ªtype config.blend then throw Error "
          #{M}If set, `config.blend` must be array not #{ªtype config.blend}"
        else
          if ! Item.Mesh.validBlend[ config.blend[0] ] then throw Error "
            #{M}`config.blend[0]` is not recognised by WebGL"
          if ! Item.Mesh.validBlend[ config.blend[1] ] then throw Error "
            #{M}`config.blend[1]` is not recognised by WebGL"
          @sBlend = @main.gl[ config.blend[0] ]
          @dBlend = @main.gl[ config.blend[1] ]




Self-Assigned Properties
------------------------




Methods
-------


#### `xx()`
- xx `<xx>`  (optional) xx

@todo describe

      xx: (xx) ->




Static Properties
-----------------


#### `validRenderMode <object>`
Defines valid WebGL render-mode constants.  

    Item.Mesh.validRenderMode =
      'POINTS'        :1 # a single dot per vertex, so 10 vertices draws 10 dots
      'LINES'         :1 # lines between vertex pairs, 10 vertices draws 5 lines
      'LINE_STRIP'    :1 # lines between all vertices, 10 vertices draws 9 lines
      'LINE_LOOP'     :1 # as LINE_STRIP but connects last vertex back to first
      'TRIANGLES'     :1 # a triangle for each set of three consecutive vertices
      'TRIANGLE_STRIP':1 # vertex 4 adds a new triangle after the 1st is drawn
      'TRIANGLE_FAN'  :1 # like TRIANGLE_STRIP, but creates a fan shaped output


#### `validBlend <object>`
Defines valid WebGL blend constants.  

    Item.Mesh.validBlend =
      'ZERO'               :1
      # 0          0          0          0
      # Multiply all colors by 0
      'ONE'                :1
      # 1          1          1          1
      # Multiply all colors by 1
      'SRC_COLOR'          :1
      # Rs         Gs         Bs         As
      # Multiply by source color value
      'ONE_MINUS_SRC_COLOR':1
      # (1-Rs)     (1-Gs)     (1-Bs)     (1-As)
      # Multiply by 1 minus each color value
      'DST_COLOR'          :1
      # Rd         Gd         Bd         Ad
      # Multiply by destination color value
      'ONE_MINUS_DST_COLOR':1
      # (1-Rd)     (1-Gd)     (1-Bd)     (1-Ad)
      # Multiply by 1 minus each color value
      'SRC_ALPHA'          :1
      # As         As         As         As
      # Multiply all colors by source alpha value
      'ONE_MINUS_SRC_ALPHA':1
      # (1-As)     (1-As)     (1-As)     (1-As)
      # Multiply all colors by 1 minus source alpha value
      'DST_ALPHA'          :1
      # Ad         Ad         Ad         Ad
      # Multiply all colors by destination alpha value
      'ONE_MINUS_DST_ALPHA':1
      # (1-Ad)     (1-Ad)     (1-Ad)     (1-Ad)
      # Multiply all colors by 1 minus each alpha value
      'SRC_ALPHA_SATURATE' :1
      # min(As,Ad) min(As,Ad) min(As,Ad) 1
      # Multiply by the smaller of source or dest alpha value




