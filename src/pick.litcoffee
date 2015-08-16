Pick
====

#### Helpers for Item-picking

Note that these functions will often be called 1000s of times per second, so 
they’re designed to run as fast as possible. That means they do no type or 
range checking, so it’s up to the implementing app to pass valid arguments. 




@todo describe

    pick = {}




#### `indexToColor()`
- `index <integer>`  xx
- `<Float32Array>`   xx

Xx. 

    pick.indexToColor = (index) ->

Convert `index` into a binary string exactly 24 digits long. Then convert that 
to an array for quick lookup. Note that unique colors will not be returned for 
`index` values greater than `0x111111111111111111111111`.

      i = ('00000000000000000000000' + index.toString 2).slice(-24).split ''
      #ª i.join('')

The least significant index bit becomes the most significant red bit. The 
fourth-least significant index bit becomes the second-most significant red bit. 

      r = "#{i[23]}#{i[20]}#{i[17]}#{i[14]}#{i[11]}#{i[8]}#{i[5]}#{i[2]}"
      g = "#{i[22]}#{i[19]}#{i[16]}#{i[13]}#{i[10]}#{i[7]}#{i[4]}#{i[1]}"
      b = "#{i[21]}#{i[18]}#{i[15]}#{i[12]}#{i[ 9]}#{i[6]}#{i[3]}#{i[0]}"
      #ª r, parseInt(r,2), g, parseInt(g,2), b, parseInt(b,2)

Xx. @todo describe

      return new Float32Array [
        parseInt(r,2)/255 # red
        parseInt(g,2)/255 # green
        parseInt(b,2)/255 # blue
        1.0               # alpha is not useful for color-picking @todo why?
      ]




#### `colorToIndex()`
- `color <Uint8Array>`  must contain at least three integers, treated as r, g, b
- `<integer>`           xx

Xx. 

    pick.colorToIndex = (color) ->

Xx. 
Bitwise `XOR` returns a one in each bit position for which the corresponding 
bits of either but not both operands are ones.
@todo check the performance of this - is it significantly quicker for 0-511?

      #ª 'HI!', 0x1f.toString(2), color[2].toString(2), (0x1f & color[2]).toString(2)
      if 0 == (0x1f & color[0]) + (0x1f & color[1]) + (0x1f & color[2])
        return pick.qikColorToIndex color

Convert the red, green and blue components into binary strings exactly eight 
digits long. Then convert that to an array for quick lookup. 

      r = ('0000000' + color[0].toString 2).slice(-8).split ''
      g = ('0000000' + color[1].toString 2).slice(-8).split ''
      b = ('0000000' + color[2].toString 2).slice(-8).split ''
      #ª r.join(''), parseInt(r.join(''), 2), g.join(''), parseInt(g.join(''), 2), b.join(''), parseInt(b.join(''), 2)

The most significant red bit becomes the least significant index bit. The 
second-most significant red bit becomes the fourth-least significant index bit. 

      i = "#{b[7]}#{g[7]}#{r[7]}" +
          "#{b[6]}#{g[6]}#{r[6]}" +
          "#{b[5]}#{g[5]}#{r[5]}" +
          "#{b[4]}#{g[4]}#{r[4]}" +
          "#{b[3]}#{g[3]}#{r[3]}" +
          "#{b[2]}#{g[2]}#{r[2]}" +
          "#{b[1]}#{g[1]}#{r[1]}" +
          "#{b[0]}#{g[0]}#{r[0]}"
      #ª i, parseInt(i, 2)

Xx. @todo describe

      return parseInt i, 2




#### `qikColorToIndex()`
- `color <Uint8Array>`  must contain at least three integers, treated as r, g, b
- `<integer>`           xx

High performance version of `colorToIndex()`, which can only operate on colors 
whose resultant index is between 0 and 511. 

    pick.qikColorToIndex = (color) ->

Convert the red, green and blue components into binary strings exactly eight 
digits long. Then convert that to an array for quick lookup. 

      r = (color[0].toString 2).split ''
      g = (color[1].toString 2).split ''
      b = (color[2].toString 2).split ''
      #ª 'qik: ', r.join(''), parseInt(r.join(''), 2), g.join(''), parseInt(g.join(''), 2), b.join(''), parseInt(b.join(''), 2)

The most significant red bit becomes the least significant index bit. The 
second-most significant red bit becomes the fourth-least significant index bit. 

      i = "#{b[2]||0}#{g[2]||0}#{r[2]||0}" +
          "#{b[1]||0}#{g[1]||0}#{r[1]||0}" +
          "#{b[0]}#{g[0]}#{r[0]}"
      #ª 'qik: ', i, parseInt(i, 2)

Xx. @todo describe

      return parseInt i, 2




