Main
====

@todo describe


#### The main class for Nwang

    class Main
      C: ªC
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->




Properties
----------


#### `xx <xx>`
Xx. @todo describe

        @xx = null




Methods
-------


#### `sf3()`
- `x <number|string>`  Xx 

Xx. @todo describe

      sf3: (x) ->
        tx = typeof x


##### If `x` is a number, convert it to a glyph. 

        if ªN == tx

Throw a `RangeError` if `x` is less than the lowest valid value, -10000. 

          if -10000 > x then throw RangeError "#{@C}:sf3()\n  `x` is < -10000"

Numbers in the range -10000 to -1000 are rounded to the nearest 10. 

          if -1000 > x
            return String.fromCharCode(0xAFE8 + Math.round x / 10)

Numbers in the range -1000 to -100 are rounded to the nearest unit. 

          if -100 > x
            return String.fromCharCode(0xB36C + Math.round x)

Numbers in the range -100 to -10 are rounded to the nearest 0.1. 

          if -10 > x
            return String.fromCharCode(0xB6F0 + Math.round x * 10)

Numbers in the range -10 to -1 are rounded to the nearest 0.01. 

          if -1 > x
            return String.fromCharCode(0xBA74 + Math.round x * 100)

Numbers in the range -1 to -0.1 are rounded to the nearest 0.001. 

          if -0.1 > x
            return String.fromCharCode(0xBDF8 + Math.round x * 1000)

Numbers in the range -0.1 to 0.1 are rounded to the nearest 0.0001. 

          if 0.1 > x
            return String.fromCharCode(0xC17C + Math.round x * 10000)

Numbers in the range 0.1 to 1 are rounded to the nearest 0.001. 

          if 1 > x
            return String.fromCharCode(0xC500 + Math.round x * 1000)

Numbers in the range 1 to 10 are rounded to the nearest 0.01. 

          if 10 > x
            return String.fromCharCode(0xC884 + Math.round x * 100)

Numbers in the range 10 to 100 are rounded to the nearest 0.1. 

          if 100 > x
            return String.fromCharCode(0xCC08 + Math.round x * 10)

Numbers in the range 100 to 1000 are rounded to the nearest unit. 

          if 1000 > x
            return String.fromCharCode(0xCF8C + Math.round x)

Numbers in the range 1000 to 10000 are rounded to the nearest 10. 

          if 10000 >= x
            return String.fromCharCode(0xD310 + Math.round x / 10)

Throw a `RangeError` if `x` is [not a number](https://goo.gl/oIAC8X). 

          if x != x # equivalent to `isNaN(x)`
            throw RangeError "#{@C}:sf3()\n  `x` is not a number"

Throw a `TypeError` if `x` is greater than the highest valid value, 10000. 

          throw RangeError "#{@C}:sf3()\n  `x` is > 10000"


##### If `x` is a string, convert it to a number. 

        if ªS == tx
          u = x.charCodeAt 0 # unicode codepoint

Throw a `RangeError` if `u` is less than the lowest valid value, 0xAC00. 

          if 0xAC00 > u
            throw RangeError "#{@C}:sf3()\n  `x` codepoint #{u} < #{0xAC00}"

Numbers in the range -10000 to -1000 are rounded to the nearest 10. 

          if 0xAF85 > u
            return '' + ((u - 0xAFE8) * 10)

Numbers in the range -1000 to -100 are rounded to the nearest unit. 

          if 0xB309 > u
            return '' + (u - 0xB36C)

Numbers in the range -100 to -10 are rounded to the nearest 0.1. 

          if 0xB68D > u
            return ((u - 0xB6F0) * 0.1).toFixed 1

Numbers in the range -10 to -1 are rounded to the nearest 0.01. 

          if 0xBA11 > u
            return ((u - 0xBA74) * 0.01).toFixed 2

Numbers in the range -1 to -0.1 are rounded to the nearest 0.001. 

          if 0xBD95 > u
            return ((u - 0xBDF8) * 0.001).toFixed 3

Numbers in the range -0.1 to 0.1 are rounded to the nearest 0.0001. 

          if 0xC564 > u
            return ((u - 0xC17C) * 0.0001).toFixed 4

Numbers in the range 0.1 to 1 are rounded to the nearest 0.001. 

          if 0xC8E8 > u
            return ((u - 0xC500) * 0.001).toFixed 3

Numbers in the range 1 to 10 are rounded to the nearest 0.01. 

          if 0xCC6C > u
            return ((u - 0xC884) * 0.01).toFixed 2

Numbers in the range 10 to 100 are rounded to the nearest 0.1. 

          if 0xCFF0 > u
            return ((u - 0xCC08) * 0.1).toFixed 1

Numbers in the range 100 to 1000 are rounded to the nearest unit. 

          if 0xD374 > u
            return '' + (u - 0xCF8C)

Numbers in the range 1000 to 10000 are rounded to the nearest 10. 

          if 0xD6F8 >= u
            return '' + ((u - 0xD310) * 10)

Throw a `RangeError` if `x` is an empty string. 

          if u != u # equivalent to `isNaN(x)`
            throw RangeError "#{@C}:sf3()\n  `x` is an empty string"

Throw a `RangeError` if `u` is greater than the highest valid value, 0xD6F8. 

          throw RangeError "#{@C}:sf3()\n  `x` codepoint #{u} > #{0xD6F8}"


##### Not a number or a string, so throw a `TypeError`. 

        throw TypeError "#{@C}:sf3()\n  `x` is #{tx} not number|string"



