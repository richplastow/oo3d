9-1-02 `pick.colorToIndex()`
============================


    tudor.add [
      "9-1-02 `pick.colorToIndex()`"
      tudor.is




      "The function exists, and returns the expected type"


      "The container exists"
      ªO
      -> pick

      "The function exists"
      ªF
      -> pick.colorToIndex

      "`pick.colorToIndex(0)` returns a number"
      ªN
      -> pick.colorToIndex [1,2,3,255]




      "`pick.colorToIndex()` usage"
      tudor.equal


      "Black with 100% alpha returns zero"
      0
      -> pick.colorToIndex [0,0,0,255]


      "50% brightness red returns `1`"
      1
      -> pick.colorToIndex [128,0,0,255]


      "combinations of R, G and B at 50% brightness return `1` to `7`"
      "1 2 3 4 5 6 7"
      ->  (pick.colorToIndex color for color in [
            [ 128,   0,   0, 255 ]
            [   0, 128,   0, 255 ]
            [ 128, 128,   0, 255 ]
            [   0,   0, 128, 255 ]
            [ 128,   0, 128, 255 ]
            [   0, 128, 128, 255 ]
            [ 128, 128, 128, 255 ]
          ]).join ' '


      "various shades of red return `585, 73, 521, 9, 577, 65, 513, 1, 584, 72, 520, 8, 576, 64, 512, 0`"
      "585 73 521 9 577 65 513 1 584 72 520 8 576 64 512 0"
      ->  (pick.colorToIndex color for color in [
            [ 240,   0,   0, 255 ] # 585
            [ 224,   0,   0, 255 ] #  73
            [ 208,   0,   0, 255 ] # 521
            [ 192,   0,   0, 255 ] #   9
            [ 176,   0,   0, 255 ] # 577
            [ 160,   0,   0, 255 ] #  65
            [ 144,   0,   0, 255 ] # 513
            [ 128,   0,   0, 255 ] #   1
            [ 112,   0,   0, 255 ] # 584
            [  96,   0,   0, 255 ] #  72
            [  80,   0,   0, 255 ] # 520
            [  64,   0,   0, 255 ] #   8
            [  48,   0,   0, 255 ] # 576
            [  32,   0,   0, 255 ] #  64
            [  16,   0,   0, 255 ] # 512
            [   0,   0,   0, 255 ] #   0
          ]).join ' '


      "various shades of green return `1170, 146, 1042, 18, 1154, 130, 1026, 2, 1168, 144, 1040, 16, 1152, 128, 1024, 0`"
      "1170 146 1042 18 1154 130 1026 2 1168 144 1040 16 1152 128 1024 0"
      ->  (pick.colorToIndex color for color in [
            [   0, 240,   0, 255 ] # 1170
            [   0, 224,   0, 255 ] #  146
            [   0, 208,   0, 255 ] # 1042
            [   0, 192,   0, 255 ] #   18
            [   0, 176,   0, 255 ] # 1154
            [   0, 160,   0, 255 ] #  130
            [   0, 144,   0, 255 ] # 1026
            [   0, 128,   0, 255 ] #    2
            [   0, 112,   0, 255 ] # 1168
            [   0,  96,   0, 255 ] #  144
            [   0,  80,   0, 255 ] # 1040
            [   0,  64,   0, 255 ] #   16
            [   0,  48,   0, 255 ] # 1152
            [   0,  32,   0, 255 ] #  128
            [   0,  16,   0, 255 ] # 1024
            [   0,   0,   0, 255 ] #    0
          ]).join ' '


      "various shades of blue return `2340, 292, 2084, 36, 2308, 260, 2052, 4, 2336, 288, 2080, 32, 2304, 256, 2048, 0`"
      "2340 292 2084 36 2308 260 2052 4 2336 288 2080 32 2304 256 2048 0"
      ->  (pick.colorToIndex color for color in [
            [   0,   0, 240, 255 ] # 2340
            [   0,   0, 224, 255 ] #  292
            [   0,   0, 208, 255 ] # 2084
            [   0,   0, 192, 255 ] #   36
            [   0,   0, 176, 255 ] # 2308
            [   0,   0, 160, 255 ] #  260
            [   0,   0, 144, 255 ] # 2052
            [   0,   0, 128, 255 ] #    4
            [   0,   0, 112, 255 ] # 2336
            [   0,   0,  96, 255 ] #  288
            [   0,   0,  80, 255 ] # 2080
            [   0,   0,  64, 255 ] #   32
            [   0,   0,  48, 255 ] # 2304
            [   0,   0,  32, 255 ] #  256
            [   0,   0,  16, 255 ] # 2048
            [   0,   0,   0, 255 ] #    0
          ]).join ' '



@todo test higher values

@todo test combinations of R, G, and B

@todo test values of alpha



    ];












