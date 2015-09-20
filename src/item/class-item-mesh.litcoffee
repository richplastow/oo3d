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


#### `bP <Buffer.Position>`
Xx. @todo describe

        if ªU == type = ( ªtype (val = config.positionI) )
          @bP = @main._all[0] # use Oo3d’s default Buffer.Position
        else
          @bP = @main._all[val]
          if ! @bP
            if ªN != type then throw TypeError "
              #{M}Optional `config.positionI` is #{type} not number"
            if ªMAX < val or val % 1 or 0 > val then throw RangeError "
              #{M}`config.positionI` is #{val} not 0 or a +ve int < 2^53"
            throw RangeError "
              #{M}`config.positionI` no such instance `main._all[#{val}]`"
          if 'Buffer.Position' != @bP.C then throw TypeError "
            #{M}`config.positionI` refs #{@bP.C} at `main._all[#{val}]`"


#### `bC <Buffer.Color>`
Xx. @todo describe

        if ªU == type = ( ªtype (val = config.colorI) )
          @bC = @main._all[1] # use Oo3d’s default Buffer.Color
        else
          @bC = @main._all[val]
          if ! @bC
            if ªN != type then throw TypeError "
              #{M}Optional `config.colorI` is #{type} not number"
            if ªMAX < val or val % 1 or 0 > val then throw RangeError "
              #{M}`config.colorI` is #{val} not 0 or a +ve int < 2^53"
            throw RangeError "
              #{M}`config.colorI` no such instance `main._all[#{val}]`"
          if 'Buffer.Color' != @bC.C then throw TypeError "
            #{M}`config.colorI` refs #{@bC.C} at `main._all[#{val}]`"


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


#### `count <integer>`
Xx. @todo describe  
@todo delete `count` as it always == `bP`

        if @bP.count != @bC.count then throw Error "
          #{M}`config.positionI` mismatches config.colorI"
        @count = @bP.count


#### `color <Float32Array>`
A color which can act as an ID. Useful for picking. 

        @color = pick.indexToColor @index # defined in /src/pick.coffee




Method Overrides
----------------


#### `read()`
- `format <string>`  (optional) one of 'object' (default), 'log' or 'nwang'
- `<object|string>`  xx @todo describe

Creates an object or string which describes the Item’s current state. 

      read: (format) ->
        M = "/oo3d/src/item/class-item-mesh.litcoffee
          Item.Mesh##{@index}:read()\n  "

Call the base Item class’s `read()` method. 

        out = super format

If `format` is not set (or is the string 'object'), add Item.Mesh specific 
properties to the output object. 

        if ªU == typeof format or 'object' == format
          out.bP = @bP.index
          out.bC = @bC.index

If `format` is 'log', add properties to the simple string snapshot. 

        else if 'log' == format
          out += " bP #{@bP.index} bC #{@bC.index}"

If `format` is 'nwang', return an efficient UTF-16 snapshot. See the 
[Nwang library](http://goo.gl/gaumPj) for details. 

        else if 'nwang' == format
          sf3 = @main.nwang.sf3
          out += sf3(@bP.index) + sf3(@bC.index) #@todo use alternate nwang fn, to allow integers > 999

The base Item class’s `read()` method will have dealt with an unexpected 
`format` argument, so we can just return the output here. 

        return out




#### `edit()`
- `set   <object|string>`  (optional) set properties
- `delta <object|string>`  (optional) modify properties
- `<object>`               this Item, to allow chaining

Modifies the Item’s current state. 

      edit: (set, delta) ->
        M = "/oo3d/src/item/class-item-mesh.litcoffee
          Item.Mesh##{@index}:edit()\n  "

        tSet   = ªtype set
        tmp    = {} # if an error is thrown, mesh state will not be changed

If `set` is an object, make `tmp` refs to the Buffer instances identified by 
its `bpi` and `bci` properties.  
So to change an Item.Mesh’s Buffer.Position:  
`oo3d.edit(myMeshI, { bpi:myNewBufferPositionI })`  
Or to change an Item.Mesh’s Buffer.Color at the same time:  
`oo3d.edit(myMeshI, { bpi:myNewBufferPositionI, bci:myNewColorPositionI })`

        if ªO == tSet

          if ªU != type = ( ªtype (val = set.bpi) )
            tmp.bp = @main._all[val]
            if ! tmp.bp
              if ªN != type then throw TypeError "
                #{M}Optional `set.bpi` is #{type} not number"
              if ªMAX < val or val % 1 or 0 > val then throw RangeError "
                #{M}Optional `set.bpi` is #{val} not 0 or a +ve int < 2^53"
              throw RangeError "
                #{M}Optional `set.bpi` no such instance `main._all[#{val}]`"
            if 'Buffer.Position' != tmp.bp.C then throw TypeError "
              #{M}Optional `set.bpi` refs #{tmp.bp.C} at `main._all[#{val}]`"

          if ªU != type = ( ªtype (val = set.bci) )
            tmp.bc = @main._all[val]
            if ! tmp.bc
              if ªN != type then throw TypeError "
                #{M}Optional `set.bci` is #{type} not number"
              if ªMAX < val or val % 1 or 0 > val then throw RangeError "
                #{M}Optional `set.bci` is #{val} not 0 or a +ve int < 2^53"
              throw RangeError "
                #{M}Optional `set.bci` no such instance `main._all[#{val}]`"
            if 'Buffer.Color' != tmp.bc.C then throw TypeError "
              #{M}Optional `set.bci` refs #{tmp.bc.C} at `main._all[#{val}]`"

If `set` appears to be an 'nwang' string with `bpi` and `bci` values, remove 
the last two characters and parse them into `tmp`. 

        else if ªS == tSet
          if 0xAFE8 < set.charCodeAt 0
            sf3 = @main.nwang.sf3

            if 11 == set.length
              bpval = +(sf3 set.charAt 9)
              bcval = +(sf3 set.charAt 10)
              tmp.bp = @main._all[bpval]
              tmp.bc = @main._all[bcval]
              set = set.slice 0, 9

            #@todo deal with 28-char nwang and test

            if bpval
              if ! tmp.bp
                if bpval % 1 or 0 > bpval then throw RangeError "
                  #{M}Nwang `bpi` value is #{bpval} not 0 or a +ve int"
                throw RangeError "
                  #{M}Nwang `bpi` no such instance `main._all[#{bpval}]`"
              if 'Buffer.Position' != tmp.bp.C then throw TypeError "
                #{M}Nwang `bpi` refs #{tmp.bp.C} at `main._all[#{bpval}]`"

            if bcval
              if ! tmp.bc
                if bcval % 1 or 0 > bcval then throw RangeError "
                  #{M}Nwang `bci` value is #{bcval} not 0 or a +ve int"
                throw RangeError "
                  #{M}Nwang `bci` no such instance `main._all[#{bcval}]`"
              if 'Buffer.Color' != tmp.bc.C then throw TypeError "
                #{M}Nwang `bci` refs #{tmp.bc.C} at `main._all[#{bcval}]`"

If `set` appears to be a 'log' string with `bpi` and `bci` values, remove them 
and parse them into `tmp`. 

          else
            vals = set.split ' '
            #@todo complete this and write tests

If the Buffer.Position or Buffer.Color have changed, ensure that the resulting 
Mesh.Item does not have mismatched vertex-counts. 

        if tmp.bp and tmp.bc
          if tmp.bp.count != tmp.bc.count then throw Error "
            #{M}`set.bpi` mismatches `set.bci`"
        else if tmp.bp and (tmp.bp.count != @bC.count) then throw Error "
            #{M}`set.bpi` mismatches the mesh’s Buffer.Color##{@bC.index}"
        else if tmp.bc and (tmp.bc.count != @bP.count) then throw Error "
            #{M}`set.bci` mismatches the mesh’s Buffer.Position##{@bP.index}"

Call the base Item class’s `edit()` method. 

        super set, delta

No error thrown, so write new `bp` and `bc` values to the Item.Mesh’s state. 

        if tmp.bp then @bP = tmp.bp
        if tmp.bc then @bC = tmp.bc
        @count = @bP.count #@todo delete `count` as it always == `bP`

If `set` is the special 'reset' string, restore `bP` and `bC` to default.  
@todo test

        if 'reset' == set
          @bP = 0
          @bC = 1

Allow chaining. 

        return @








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




