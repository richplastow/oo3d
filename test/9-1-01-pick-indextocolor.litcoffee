9-1-01 `pick.indexToColor()`
============================


    tudor.add [
      "9-1-01 `pick.indexToColor()`"
      tudor.is




      "The function exists, and returns the expected type"


      "The container exists"
      ªO
      -> pick

      "The function exists"
      ªF
      -> pick.indexToColor

      "`pick.indexToColor(0)` returns a Float32Array"
      'float32array'
      -> pick.indexToColor 0




      "`pick.indexToColor()` usage"
      tudor.equal


      "Returns an array with four elements"
      4
      -> pick.indexToColor(0).length


      "Zero returns black, with 100% alpha"
      '0 0 0 255'
      -> (channel * 255 for channel in pick.indexToColor 0).join ' '


      "`1` returns 50% brightness red"
      '128 0 0 255'
      -> (Math.round(channel * 255) for channel in pick.indexToColor 1).join ' '


      "`1` to `7` return combinations of R, G and B at 50% brightness"
      """
      1: 128   0   0 255
      2:   0 128   0 255
      3: 128 128   0 255
      4:   0   0 128 255
      5: 128   0 128 255
      6:   0 128 128 255
      7: 128 128 128 255
      """
      ->(for i in [1..7]
            i + ': ' + (('  ' + Math.round(channel * 255)).slice -3 for channel in pick.indexToColor i).join ' '
        ).join '\n'


      "`585, 521, 73, 9, 577, 513, 65, 1, 584, 520, 72, 8` return various shades of red"
      """
      585: 240   0   0 255
      521: 208   0   0 255
       73: 224   0   0 255
        9: 192   0   0 255
      577: 176   0   0 255
      513: 144   0   0 255
       65: 160   0   0 255
        1: 128   0   0 255
      584: 112   0   0 255
      520:  80   0   0 255
       72:  96   0   0 255
        8:  64   0   0 255
      """
      ->(for i in [
          parseInt('1001001001',2)
          parseInt('1000001001',2)

          parseInt('0001001001',2)
          parseInt('0000001001',2)

          parseInt('1001000001',2)
          parseInt('1000000001',2)

          parseInt('0001000001',2)
          parseInt('0000000001',2)

          parseInt('1001001000',2)
          parseInt('1000001000',2)

          parseInt('0001001000',2)
          parseInt('0000001000',2)
        ]
            ('  ' + i).slice(-3) + ': ' + (('  ' + Math.round(channel * 255)).slice -3 for channel in pick.indexToColor i).join ' '
        ).join '\n'


      "`585, 73, 521, 9, 577, 65, 513, 1, 584, 72, 520, 8, 576, 64, 512, 0` return various shades of red"
      """
      585: 240   0   0 255
       73: 224   0   0 255
      521: 208   0   0 255
        9: 192   0   0 255
      577: 176   0   0 255
       65: 160   0   0 255
      513: 144   0   0 255
        1: 128   0   0 255
      584: 112   0   0 255
       72:  96   0   0 255
      520:  80   0   0 255
        8:  64   0   0 255
      576:  48   0   0 255
       64:  32   0   0 255
      512:  16   0   0 255
        0:   0   0   0 255
      """
      ->(for i in [
          parseInt('1001001001',2)
          parseInt('0001001001',2)
          parseInt('1000001001',2)
          parseInt('0000001001',2)
          parseInt('1001000001',2)
          parseInt('0001000001',2)
          parseInt('1000000001',2)
          parseInt('0000000001',2)
          parseInt('1001001000',2)
          parseInt('0001001000',2)
          parseInt('1000001000',2)
          parseInt('0000001000',2)
          parseInt('1001000000',2)
          parseInt('0001000000',2)
          parseInt('1000000000',2)
          parseInt('0000000000',2)
        ]
            ('  ' + i).slice(-3) + ': ' + (('  ' + Math.round(channel * 255)).slice -3 for channel in pick.indexToColor i).join ' '
        ).join '\n'


      "`1170, 146, 1042, 18, 1154, 130, 1026, 2, 1168, 144, 1040, 16, 1152, 128, 1024, 0` return various shades of green"
      """
      1170:   0 240   0 255
       146:   0 224   0 255
      1042:   0 208   0 255
        18:   0 192   0 255
      1154:   0 176   0 255
       130:   0 160   0 255
      1026:   0 144   0 255
         2:   0 128   0 255
      1168:   0 112   0 255
       144:   0  96   0 255
      1040:   0  80   0 255
        16:   0  64   0 255
      1152:   0  48   0 255
       128:   0  32   0 255
      1024:   0  16   0 255
         0:   0   0   0 255
      """
      ->(for i in [
          parseInt('10010010010',2)
          parseInt('00010010010',2)
          parseInt('10000010010',2)
          parseInt('00000010010',2)
          parseInt('10010000010',2)
          parseInt('00010000010',2)
          parseInt('10000000010',2)
          parseInt('00000000010',2)
          parseInt('10010010000',2)
          parseInt('00010010000',2)
          parseInt('10000010000',2)
          parseInt('00000010000',2)
          parseInt('10010000000',2)
          parseInt('00010000000',2)
          parseInt('10000000000',2)
          parseInt('00000000000',2)
        ]
            ('   ' + i).slice(-4) + ': ' + (('  ' + Math.round(channel * 255)).slice -3 for channel in pick.indexToColor i).join ' '
        ).join '\n'


      "`2340, 292, 2084, 36, 2308, 260, 2052, 4, 2336, 288, 2080, 32, 2304, 256, 2048, 0` return various shades of blue"
      """
      2340:   0   0 240 255
       292:   0   0 224 255
      2084:   0   0 208 255
        36:   0   0 192 255
      2308:   0   0 176 255
       260:   0   0 160 255
      2052:   0   0 144 255
         4:   0   0 128 255
      2336:   0   0 112 255
       288:   0   0  96 255
      2080:   0   0  80 255
        32:   0   0  64 255
      2304:   0   0  48 255
       256:   0   0  32 255
      2048:   0   0  16 255
         0:   0   0   0 255
      """
      ->(for i in [
          parseInt('100100100100',2)
          parseInt('000100100100',2)
          parseInt('100000100100',2)
          parseInt('000000100100',2)
          parseInt('100100000100',2)
          parseInt('000100000100',2)
          parseInt('100000000100',2)
          parseInt('000000000100',2)
          parseInt('100100100000',2)
          parseInt('000100100000',2)
          parseInt('100000100000',2)
          parseInt('000000100000',2)
          parseInt('100100000000',2)
          parseInt('000100000000',2)
          parseInt('100000000000',2)
          parseInt('000000000000',2)
        ]
            ('   ' + i).slice(-4) + ': ' + (('  ' + Math.round(channel * 255)).slice -3 for channel in pick.indexToColor i).join ' '
        ).join '\n'

@todo test higher values

@todo test combinations of R, G, and B




    ];







