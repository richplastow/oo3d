02 sf3() Three Significant Figures
==================================


    tudor.add [
      "02 sf3() Three Significant Figures"




      "The method is, and returns, expected types"
      tudor.is

      -> [new Main]

      "sf3() is a function"
      ªF
      (nwang) -> nwang.sf3

      "pass a number to get a string"
      ªS
      (nwang) -> nwang.sf3 123

      "pass a string to _also_ get a string"
      ªS
      (nwang) -> nwang.sf3 '\uBCDEabc'




      "Throws errors as expected"
      tudor.throw

      "pass a boolean"
      """
      Nwang:sf3()
        `x` is boolean not number|string
      """
      (nwang) -> nwang.sf3 true


      "-Infinity is too low"
      """
      Nwang:sf3()
        `x` is < -10000
      """
      (nwang) -> nwang.sf3 -Infinity

      "-123456 is too low"
      """
      Nwang:sf3()
        `x` is < -10000
      """
      (nwang) -> nwang.sf3 -123456

      "-10000.0001 is too low"
      """
      Nwang:sf3()
        `x` is < -10000
      """
      (nwang) -> nwang.sf3 -10000.0001


      "Infinity is too high"
      """
      Nwang:sf3()
        `x` is > 10000
      """
      (nwang) -> nwang.sf3 Infinity

      "23456 is too high"
      """
      Nwang:sf3()
        `x` is > 10000
      """
      (nwang) -> nwang.sf3 23456

      "10000.0001 is too high"
      """
      Nwang:sf3()
        `x` is > 10000
      """
      (nwang) -> nwang.sf3 10000.0001

      "NaN is, er, not a number"
      """
      Nwang:sf3()
        `x` is not a number
      """
      (nwang) -> nwang.sf3 NaN


      "An empty string"
      """
      Nwang:sf3()
        `x` is an empty string
      """
      (nwang) -> nwang.sf3 ''

      "The codepoint of 'A' is too low"
      """
      Nwang:sf3()
        `x` codepoint 65 < 44032
      """
      (nwang) -> nwang.sf3 'A'

      "The codepoint of 'U+ABFF' is too low"
      """
      Nwang:sf3()
        `x` codepoint 44031 < 44032
      """
      (nwang) -> nwang.sf3 '\uABFF'

      "The codepoint of 'U+D6F9' is too high"
      """
      Nwang:sf3()
        `x` codepoint 55033 > 55032
      """
      (nwang) -> nwang.sf3 '\uD6F9'




      "Converts numbers to glyphs as expected"
      tudor.equal


Numbers in the range -10000 to -1000 are rounded to the nearest 10. 

      "-10000 returns U+AC00"
      String.fromCharCode 0xAC00
      (nwang) -> nwang.sf3 -10000

      "-9999.99999 also returns U+AC00"
      String.fromCharCode 0xAC00
      (nwang) -> nwang.sf3 -9999.99999

      "-9995.00001 also returns U+AC00"
      String.fromCharCode 0xAC00
      (nwang) -> nwang.sf3 -9995.00001

      "-9995 returns U+AC01"
      String.fromCharCode 0xAC01
      (nwang) -> nwang.sf3 -9995

      "-9990 also returns U+AC01"
      String.fromCharCode 0xAC01
      (nwang) -> nwang.sf3 -9990

      "-9985.00001 also returns U+AC01"
      String.fromCharCode 0xAC01
      (nwang) -> nwang.sf3 -9985.00001

      "-9985 returns U+AC02"
      String.fromCharCode 0xAC02
      (nwang) -> nwang.sf3 -9985

      "-1005.00001 returns U+AF83"
      String.fromCharCode 0xAF83
      (nwang) -> nwang.sf3 -1005.00001

      "-1005 returns U+AF84"
      String.fromCharCode 0xAF84
      (nwang) -> nwang.sf3 -1005

      "-1000.00001 also returns U+AF84"
      String.fromCharCode 0xAF84
      (nwang) -> nwang.sf3 -1000.00001


Numbers in the range -1000 to -100 are rounded to the nearest unit. 

      "-1000 also returns U+AF84"
      String.fromCharCode 0xAF84
      (nwang) -> nwang.sf3 -1000

      "-999.9999 also returns U+AF84"
      String.fromCharCode 0xAF84
      (nwang) -> nwang.sf3 -999.9999

      "-999.5001 also returns U+AF84"
      String.fromCharCode 0xAF84
      (nwang) -> nwang.sf3 -999.5001

      "-999.5 returns U+AF85"
      String.fromCharCode 0xAF85
      (nwang) -> nwang.sf3 -999.5

      "-999 also returns U+AF85"
      String.fromCharCode 0xAF85
      (nwang) -> nwang.sf3 -999

      "-998.50001 also returns U+AF85"
      String.fromCharCode 0xAF85
      (nwang) -> nwang.sf3 -998.50001

      "-101.50001 returns U+B306"
      String.fromCharCode 0xB306
      (nwang) -> nwang.sf3 -101.50001

      "-101.5 returns U+B307"
      String.fromCharCode 0xB307
      (nwang) -> nwang.sf3 -101.5

      "-100.50001 also returns U+B307"
      String.fromCharCode 0xB307
      (nwang) -> nwang.sf3 -100.50001

      "-100.5 returns U+B308"
      String.fromCharCode 0xB308
      (nwang) -> nwang.sf3 -100.5


Numbers in the range -100 to -10 are rounded to the nearest 0.1. 

      "-100 also returns U+B308"
      String.fromCharCode 0xB308
      (nwang) -> nwang.sf3 -100

      "-99.9999 also returns U+B308"
      String.fromCharCode 0xB308
      (nwang) -> nwang.sf3 -99.9999

      "-99.950001 also returns U+B308"
      String.fromCharCode 0xB308
      (nwang) -> nwang.sf3 -99.950001

      "-99.95 returns U+B309"
      String.fromCharCode 0xB309
      (nwang) -> nwang.sf3 -99.95

      "-99.94999 also returns U+B309"
      String.fromCharCode 0xB309
      (nwang) -> nwang.sf3 -99.94999

      "-99.9 also returns U+B309"
      String.fromCharCode 0xB309
      (nwang) -> nwang.sf3 -99.9

      "-99.8501 also returns U+B309"
      String.fromCharCode 0xB309
      (nwang) -> nwang.sf3 -99.8501

      "-99.85 returns U+B30A"
      String.fromCharCode 0xB30A
      (nwang) -> nwang.sf3 -99.85

      "-10.099 returns U+B68B"
      String.fromCharCode 0xB68B
      (nwang) -> nwang.sf3 -10.099

      "-10.05123 also returns U+B68B"
      String.fromCharCode 0xB68B
      (nwang) -> nwang.sf3 -10.05123

      "-10.05 returns U+B68C"
      String.fromCharCode 0xB68C
      (nwang) -> nwang.sf3 -10.05

      "-10.000005 also returns U+B68C"
      String.fromCharCode 0xB68C
      (nwang) -> nwang.sf3 -10.000005


Numbers in the range -10 to -1 are rounded to the nearest 0.01. 

      "-10 also returns U+B68C"
      String.fromCharCode 0xB68C
      (nwang) -> nwang.sf3 -10

      "-9.9999 also returns U+B68C"
      String.fromCharCode 0xB68C
      (nwang) -> nwang.sf3 -9.9999

      "-9.9950001 also returns U+B68C"
      String.fromCharCode 0xB68C
      (nwang) -> nwang.sf3 -9.9950001

      "-9.995 returns U+B68D"
      String.fromCharCode 0xB68D
      (nwang) -> nwang.sf3 -9.995

      "-9.99 also returns U+B68D"
      String.fromCharCode 0xB68D
      (nwang) -> nwang.sf3 -9.99

      "-1.0051 returns U+BA0F"
      String.fromCharCode 0xBA0F
      (nwang) -> nwang.sf3 -1.0051

      "-1.005 returns U+BA10"
      String.fromCharCode 0xBA10
      (nwang) -> nwang.sf3 -1.005

      "-1.001 also returns U+BA10"
      String.fromCharCode 0xBA10
      (nwang) -> nwang.sf3 -1.001


Numbers in the range -1 to -0.1 are rounded to the nearest 0.001. 

      "-1 also returns U+BA10"
      String.fromCharCode 0xBA10
      (nwang) -> nwang.sf3 -1

      "-0.99999 also returns U+BA10"
      String.fromCharCode 0xBA10
      (nwang) -> nwang.sf3 -0.99999

      "-0.9995001 also returns U+BA10"
      String.fromCharCode 0xBA10
      (nwang) -> nwang.sf3 -0.9995001

      "-0.9995 returns U+BA11"
      String.fromCharCode 0xBA11
      (nwang) -> nwang.sf3 -0.9995

      "-0.999 also returns U+BA11"
      String.fromCharCode 0xBA11
      (nwang) -> nwang.sf3 -0.999

      "-0.100001 returns U+BD94"
      String.fromCharCode 0xBD94
      (nwang) -> nwang.sf3 -0.100001


Numbers in the range -0.1 to -0.01 are rounded to the nearest 0.0001. 

      "-0.1 also returns U+BD94"
      String.fromCharCode 0xBD94
      (nwang) -> nwang.sf3 -0.1

      "-0.0999999 also returns U+BD94"
      String.fromCharCode 0xBD94
      (nwang) -> nwang.sf3 -0.0999999

      "-0.09995001 also returns U+BD94"
      String.fromCharCode 0xBD94
      (nwang) -> nwang.sf3 -0.09995001

      "-0.09995 returns U+BD95"
      String.fromCharCode 0xBD95
      (nwang) -> nwang.sf3 -0.09995

      "-0.0999 also returns U+BD95"
      String.fromCharCode 0xBD95
      (nwang) -> nwang.sf3 -0.0999

      "-0.0100001 returns U+C118"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.0100001


Numbers in the range -0.01 to -0.0001 are _also_ rounded to the nearest 0.0001. 

      "-0.01 also returns U+C118"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.01

      "-0.00999999 also returns U+C118"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.00999999

      "-0.009995001 also returns U+C118"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.009995001

      "-0.009995 _also_ returns U+C119 (rounded to -0.01, _not_ -0.00999)"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.009995

      "-0.00999 also returns U+C119"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.009995

      "-0.0099500001 returns U+C118 (rounded to -0.01)"
      String.fromCharCode 0xC118
      (nwang) -> nwang.sf3 -0.0099500001

      "-0.00995 returns U+C119 (rounded to -0.0099)"
      String.fromCharCode 0xC119
      (nwang) -> nwang.sf3 -0.00995

      "-0.009900123 also returns U+C119"
      String.fromCharCode 0xC119
      (nwang) -> nwang.sf3 -0.009900123

      "-0.0099 also returns U+C119"
      String.fromCharCode 0xC119
      (nwang) -> nwang.sf3 -0.0099

      "-0.0098500001 also returns U+C119"
      String.fromCharCode 0xC119
      (nwang) -> nwang.sf3 -0.0098500001

      "-0.00985 returns U+C11A"
      String.fromCharCode 0xC11A
      (nwang) -> nwang.sf3 -0.00985

      "-0.0002 returns U+C17A"
      String.fromCharCode 0xC17A
      (nwang) -> nwang.sf3 -0.0002

      "-0.000175 also returns U+C17A"
      String.fromCharCode 0xC17A
      (nwang) -> nwang.sf3 -0.000175

      "-0.0001500001 also returns U+C17A"
      String.fromCharCode 0xC17A
      (nwang) -> nwang.sf3 -0.0001500001

      "-0.00015 returns U+C17B"
      String.fromCharCode 0xC17B
      (nwang) -> nwang.sf3 -0.00015


Numbers between -0.0001 and 0.0001 when rounded to the nearest 0.0001 become 0. 

      "-0.0001 also returns U+C17B"
      String.fromCharCode 0xC17B
      (nwang) -> nwang.sf3 -0.0001

      "-0.0000501234 also returns U+C17B"
      String.fromCharCode 0xC17B
      (nwang) -> nwang.sf3 -0.0000501234

      "-0.000050001 also returns U+C17B"
      String.fromCharCode 0xC17B
      (nwang) -> nwang.sf3 -0.000050001

      "-0.00005 returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 -0.00005

      "-0.00004 also returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 -0.00004

      "-0.0000000001 also returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 -0.0000000001

      "0 also returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 0

      "0.0000000001 also returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 0.0000000001

      "0.0000456789 also returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 0.0000456789

      "0.0000499999999 also returns U+C17C"
      String.fromCharCode 0xC17C
      (nwang) -> nwang.sf3 0.0000499999999

      "0.00005 returns U+C17D"
      String.fromCharCode 0xC17D
      (nwang) -> nwang.sf3 0.00005

      "0.0000500001 returns U+C17D"
      String.fromCharCode 0xC17D
      (nwang) -> nwang.sf3 0.0000500001

      "0.0000501234 also returns U+C17D"
      String.fromCharCode 0xC17D
      (nwang) -> nwang.sf3 0.0000501234


Numbers in the range 0.0001 to 0.01 are _also_ rounded to the nearest 0.0001. 

      "0.0001 also returns U+C17D"
      String.fromCharCode 0xC17D
      (nwang) -> nwang.sf3 0.0001

      "0.00015 also returns U+C17D"
      String.fromCharCode 0xC17D
      (nwang) -> nwang.sf3 0.00015

      "0.0001500001 returns U+C17E"
      String.fromCharCode 0xC17E
      (nwang) -> nwang.sf3 0.0001500001

      "0.000175 also returns U+C17E"
      String.fromCharCode 0xC17E
      (nwang) -> nwang.sf3 0.000175

      "0.0002 also returns U+C17E"
      String.fromCharCode 0xC17E
      (nwang) -> nwang.sf3 0.0002

      "0.00985 returns U+C1DF"
      String.fromCharCode 0xC1DF
      (nwang) -> nwang.sf3 0.00985

      "0.0098500001 also returns U+C1DF"
      String.fromCharCode 0xC1DF
      (nwang) -> nwang.sf3 0.0098500001

      "0.0099 also returns U+C1DF"
      String.fromCharCode 0xC1DF
      (nwang) -> nwang.sf3 0.0099

      "0.009900123 also returns U+C1DF"
      String.fromCharCode 0xC1DF
      (nwang) -> nwang.sf3 0.009900123

      "0.009949999 also returns U+C1DF (rounded to 0.0099)"
      String.fromCharCode 0xC1DF
      (nwang) -> nwang.sf3 0.009949999

      "0.00995 returns U+C1E0 (rounded to 0.01)"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.00995

      "0.0099500001 also returns U+C1E0 (rounded to 0.01)"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.0099500001

      "0.009995 _also_ returns U+C1E0 (rounded to -0.01, _not_ -0.00999)"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.009995

      "0.009995001 also returns U+C1E0"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.009995001

      "0.00999999 also returns U+C1E0"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.00999999


Numbers in the range 0.01 to 0.1 are _also_ rounded to the nearest 0.0001. 

      "0.01 also returns U+C1E0"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.01

      "0.01000001 also returns U+C1E0"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.01000001

      "0.0100499999 also returns U+C1E0"
      String.fromCharCode 0xC1E0
      (nwang) -> nwang.sf3 0.0100499999

      "0.01005 returns U+C1E1"
      String.fromCharCode 0xC1E1
      (nwang) -> nwang.sf3 0.01005

      "0.01014999999 also returns U+C1E1"
      String.fromCharCode 0xC1E1
      (nwang) -> nwang.sf3 0.01014999999

      "0.0102 returns U+C1E2"
      String.fromCharCode 0xC1E2
      (nwang) -> nwang.sf3 0.0102

      "0.09994999 returns U+C563"
      String.fromCharCode 0xC563
      (nwang) -> nwang.sf3 0.09994999

      "0.09995 returns U+C564 (rounded to 0.1)"
      String.fromCharCode 0xC564
      (nwang) -> nwang.sf3 0.09995

      "0.09999999 also returns U+C564"
      String.fromCharCode 0xC564
      (nwang) -> nwang.sf3 0.09999999


Numbers in the range 0.1 to 1 are rounded to the nearest 0.001. 

      "0.1 also returns U+C564"
      String.fromCharCode 0xC564
      (nwang) -> nwang.sf3 0.1

      "0.100001 also returns U+C564"
      String.fromCharCode 0xC564
      (nwang) -> nwang.sf3 0.100001

      "0.10049999 also returns U+C564"
      String.fromCharCode 0xC564
      (nwang) -> nwang.sf3 0.10049999

      "0.1005 returns U+C565"
      String.fromCharCode 0xC565
      (nwang) -> nwang.sf3 0.1005

      "0.101 also returns U+C565"
      String.fromCharCode 0xC565
      (nwang) -> nwang.sf3 0.101

      "0.10149999 also returns U+C565"
      String.fromCharCode 0xC565
      (nwang) -> nwang.sf3 0.10149999

      "0.99849999 returns U+C8E6"
      String.fromCharCode 0xC8E6
      (nwang) -> nwang.sf3 0.99849999

      "0.9985 returns U+C8E7"
      String.fromCharCode 0xC8E7
      (nwang) -> nwang.sf3 0.9985

      "0.999 also returns U+C8E7"
      String.fromCharCode 0xC8E7
      (nwang) -> nwang.sf3 0.999

      "0.99949999 also returns U+C8E7"
      String.fromCharCode 0xC8E7
      (nwang) -> nwang.sf3 0.99949999

      "0.9995 returns U+C8E8"
      String.fromCharCode 0xC8E8
      (nwang) -> nwang.sf3 0.9995

      "0.99999999 also returns U+C8E8"
      String.fromCharCode 0xC8E8
      (nwang) -> nwang.sf3 0.99999999


Numbers in the range 1 to 10 are rounded to the nearest 0.01. 

      "1 also returns U+C8E8"
      String.fromCharCode 0xC8E8
      (nwang) -> nwang.sf3 1

      "1.000001 also returns U+C8E8"
      String.fromCharCode 0xC8E8
      (nwang) -> nwang.sf3 1.000001

      "1.0049999 also returns U+C8E8"
      String.fromCharCode 0xC8E8
      (nwang) -> nwang.sf3 1.0049999

      "1.005 also returns U+C8E8" #@todo why not U+C8E9?
      String.fromCharCode 0xC8E8
      (nwang) -> nwang.sf3 1.005

      "1.00500001 returns U+C8E9"
      String.fromCharCode 0xC8E9
      (nwang) -> nwang.sf3 1.00500001

      "1.015 also returns U+C8E9"
      String.fromCharCode 0xC8E9
      (nwang) -> nwang.sf3 1.015

      "1.01500001 returns U+C8EA"
      String.fromCharCode 0xC8EA
      (nwang) -> nwang.sf3 1.01500001

      "1.025 also returns U+C8EA"
      String.fromCharCode 0xC8EA
      (nwang) -> nwang.sf3 1.025

      "9.9799 returns U+CC6A"
      String.fromCharCode 0xCC6A
      (nwang) -> nwang.sf3 9.9799

      "9.98 also returns U+CC6A"
      String.fromCharCode 0xCC6A
      (nwang) -> nwang.sf3 9.98

      "9.980001 also returns U+CC6A"
      String.fromCharCode 0xCC6A
      (nwang) -> nwang.sf3 9.980001

      "9.9849999 also returns U+CC6A"
      String.fromCharCode 0xCC6A
      (nwang) -> nwang.sf3 9.9849999

      "9.985 returns U+CC6B"
      String.fromCharCode 0xCC6B
      (nwang) -> nwang.sf3 9.985

      "9.99 also returns U+CC6B"
      String.fromCharCode 0xCC6B
      (nwang) -> nwang.sf3 9.99

      "9.994999 also returns U+CC6B"
      String.fromCharCode 0xCC6B
      (nwang) -> nwang.sf3 9.994999

      "9.995 also returns U+CC6B" #@todo why not U+CC6C?
      String.fromCharCode 0xCC6B
      (nwang) -> nwang.sf3 9.995

      "9.995000001 returns U+CC6C"
      String.fromCharCode 0xCC6C
      (nwang) -> nwang.sf3 9.995000001

      "9.999999 also returns U+CC6C"
      String.fromCharCode 0xCC6C
      (nwang) -> nwang.sf3 9.999999


Numbers in the range 10 to 100 are rounded to the nearest 0.1. 

      "10 also returns U+CC6C"
      String.fromCharCode 0xCC6C
      (nwang) -> nwang.sf3 10

      "10.04999 also returns U+CC6C"
      String.fromCharCode 0xCC6C
      (nwang) -> nwang.sf3 10.04999

      "10.05 returns U+CC6D"
      String.fromCharCode 0xCC6D
      (nwang) -> nwang.sf3 10.05

      "10.1 also returns U+CC6D"
      String.fromCharCode 0xCC6D
      (nwang) -> nwang.sf3 10.1

      "10.14999 also returns U+CC6D"
      String.fromCharCode 0xCC6D
      (nwang) -> nwang.sf3 10.14999

      "99.94999 returns U+CFEF"
      String.fromCharCode 0xCFEF
      (nwang) -> nwang.sf3 99.94999

      "99.95 returns U+CFF0"
      String.fromCharCode 0xCFF0
      (nwang) -> nwang.sf3 99.95

      "99.99999 also returns U+CFF0"
      String.fromCharCode 0xCFF0
      (nwang) -> nwang.sf3 99.99999


Numbers in the range 100 to 1000 are rounded to the nearest unit. 

      "100 also returns U+CFF0"
      String.fromCharCode 0xCFF0
      (nwang) -> nwang.sf3 100

      "100.4999 also returns U+CFF0"
      String.fromCharCode 0xCFF0
      (nwang) -> nwang.sf3 100.4999

      "100.5 returns U+CFF1"
      String.fromCharCode 0xCFF1
      (nwang) -> nwang.sf3 100.5

      "101.49876 also returns U+CFF1"
      String.fromCharCode 0xCFF1
      (nwang) -> nwang.sf3 101.49876

      "999 returns U+D373"
      String.fromCharCode 0xD373
      (nwang) -> nwang.sf3 999

      "999.49999 also returns U+D373"
      String.fromCharCode 0xD373
      (nwang) -> nwang.sf3 999.49999

      "999.5 returns U+D374"
      String.fromCharCode 0xD374
      (nwang) -> nwang.sf3 999.5

      "999.999987654321 also returns U+D374"
      String.fromCharCode 0xD374
      (nwang) -> nwang.sf3 999.999987654321


Numbers in the range 1000 to 10000 are rounded to the nearest 10. 

      "1000 also returns U+D374"
      String.fromCharCode 0xD374
      (nwang) -> nwang.sf3 1000

      "1004.9999 also returns U+D374"
      String.fromCharCode 0xD374
      (nwang) -> nwang.sf3 1004.9999

      "1005 returns U+D375"
      String.fromCharCode 0xD375
      (nwang) -> nwang.sf3 1005

      "1010 also returns U+D375"
      String.fromCharCode 0xD375
      (nwang) -> nwang.sf3 1010

      "1014.9999 also returns U+D375"
      String.fromCharCode 0xD375
      (nwang) -> nwang.sf3 1014.9999

      "1015 returns U+D376"
      String.fromCharCode 0xD376
      (nwang) -> nwang.sf3 1015

      "9994.89 returns U+D6F7"
      String.fromCharCode 0xD6F7
      (nwang) -> nwang.sf3 9994.89

      "9995 returns U+D6F8"
      String.fromCharCode 0xD6F8
      (nwang) -> nwang.sf3 9995

      "9999 also returns U+D6F8"
      String.fromCharCode 0xD6F8
      (nwang) -> nwang.sf3 9999

      "9999.999 also returns U+D6F8"
      String.fromCharCode 0xD6F8
      (nwang) -> nwang.sf3 9999.999

      "10000 also returns U+D6F8"
      String.fromCharCode 0xD6F8
      (nwang) -> nwang.sf3 10000




      "Converts glyphs to numbers as expected"
      tudor.equal

      "U+AC00 returns -10000"
      '-10000'
      (nwang) -> nwang.sf3 '\uAC00'

      "U+AC01 returns -9990"
      '-9990'
      (nwang) -> nwang.sf3 '\uAC01'

      "U+AF84 returns -9990"
      '-1000'
      (nwang) -> nwang.sf3 '\uAF84'

      "U+AF85 returns -999"
      '-999'
      (nwang) -> nwang.sf3 '\uAF85'

      "U+AF86 returns -998"
      '-998'
      (nwang) -> nwang.sf3 '\uAF86'

      "U+B307 returns -101"
      '-101'
      (nwang) -> nwang.sf3 '\uB307'

      "U+B308 returns -100"
      '-100'
      (nwang) -> nwang.sf3 '\uB308'

      "U+B309 returns -99.9"
      '-99.9'
      (nwang) -> nwang.sf3 '\uB309'

      "U+B30A returns -99.8"
      '-99.8'
      (nwang) -> nwang.sf3 '\uB30A'

      "U+B68B returns -10.1"
      '-10.1'
      (nwang) -> nwang.sf3 '\uB68B'

      "U+B68C returns -10"
      '-10.0'
      (nwang) -> nwang.sf3 '\uB68C'

      "U+B68D returns -9.99"
      '-9.99'
      (nwang) -> nwang.sf3 '\uB68D'

      "U+B68E returns -9.98"
      '-9.98'
      (nwang) -> nwang.sf3 '\uB68E'

      "U+BA0F returns -1.01"
      '-1.01'
      (nwang) -> nwang.sf3 '\uBA0F'

      "U+BA10 returns -1.00"
      '-1.00'
      (nwang) -> nwang.sf3 '\uBA10'

      "U+BA11 returns -0.999"
      '-0.999'
      (nwang) -> nwang.sf3 '\uBA11'

      "U+BA12 returns -0.998"
      '-0.998'
      (nwang) -> nwang.sf3 '\uBA12'

      "U+BD93 returns -0.101"
      '-0.101'
      (nwang) -> nwang.sf3 '\uBD93'

      "U+BD94 returns -0.100"
      '-0.100'
      (nwang) -> nwang.sf3 '\uBD94'

      "U+BD95 returns -0.0999"
      '-0.0999'
      (nwang) -> nwang.sf3 '\uBD95'

      "U+BD96 returns -0.0998"
      '-0.0998'
      (nwang) -> nwang.sf3 '\uBD96'

      "U+C117 returns -0.0101"
      '-0.0101'
      (nwang) -> nwang.sf3 '\uC117'

      "U+C118 returns -0.0100"
      '-0.0100'
      (nwang) -> nwang.sf3 '\uC118'

      "U+C119 returns -0.0099"
      '-0.0099'
      (nwang) -> nwang.sf3 '\uC119'

      "U+C11A returns -0.0098"
      '-0.0098'
      (nwang) -> nwang.sf3 '\uC11A'

      "U+C17B returns -0.0001"
      '-0.0001'
      (nwang) -> nwang.sf3 '\uC17B'

      "U+C17C returns 0.0000"
      '0.0000'
      (nwang) -> nwang.sf3 '\uC17C'

      "U+C17D returns 0.0001"
      '0.0001'
      (nwang) -> nwang.sf3 '\uC17D'

      "U+C1DE returns 0.0098"
      '0.0098'
      (nwang) -> nwang.sf3 '\uC1DE'

      "U+C1DF returns 0.0099"
      '0.0099'
      (nwang) -> nwang.sf3 '\uC1DF'

      "U+C1E0 returns 0.0100"
      '0.0100'
      (nwang) -> nwang.sf3 '\uC1E0'

      "U+C1E1 returns 0.0101"
      '0.0101'
      (nwang) -> nwang.sf3 '\uC1E1'

      "U+C562 returns 0.0998"
      '0.0998'
      (nwang) -> nwang.sf3 '\uC562'

      "U+C563 returns 0.0999"
      '0.0999'
      (nwang) -> nwang.sf3 '\uC563'

      "U+C564 returns 0.100"
      '0.100'
      (nwang) -> nwang.sf3 '\uC564'

      "U+C565 returns 0.101"
      '0.101'
      (nwang) -> nwang.sf3 '\uC565'

      "U+C8E6 returns 0.998"
      '0.998'
      (nwang) -> nwang.sf3 '\uC8E6'

      "U+C8E7 returns 0.999"
      '0.999'
      (nwang) -> nwang.sf3 '\uC8E7'

      "U+C8E8 returns 1.00"
      '1.00'
      (nwang) -> nwang.sf3 '\uC8E8'

      "U+C8E9 returns 1.01"
      '1.01'
      (nwang) -> nwang.sf3 '\uC8E9'

      "U+CC6A returns 9.98"
      '9.98'
      (nwang) -> nwang.sf3 '\uCC6A'

      "U+CC6B returns 9.99"
      '9.99'
      (nwang) -> nwang.sf3 '\uCC6B'

      "U+CC6C returns 10.0"
      '10.0'
      (nwang) -> nwang.sf3 '\uCC6C'

      "U+CC6D returns 10.1"
      '10.1'
      (nwang) -> nwang.sf3 '\uCC6D'

      "U+CFEE returns 99.8"
      '99.8'
      (nwang) -> nwang.sf3 '\uCFEE'

      "U+CFEF returns 99.9"
      '99.9'
      (nwang) -> nwang.sf3 '\uCFEF'

      "U+CFF0 returns 100"
      '100'
      (nwang) -> nwang.sf3 '\uCFF0'

      "U+CFF1 returns 101"
      '101'
      (nwang) -> nwang.sf3 '\uCFF1'

      "U+D372 returns 998"
      '998'
      (nwang) -> nwang.sf3 '\uD372'

      "U+D373 returns 999"
      '999'
      (nwang) -> nwang.sf3 '\uD373'

      "U+D374 returns 1000"
      '1000'
      (nwang) -> nwang.sf3 '\uD374'

      "U+D375 returns 1010"
      '1010'
      (nwang) -> nwang.sf3 '\uD375'

      "U+D6F6 returns 9980"
      '9980'
      (nwang) -> nwang.sf3 '\uD6F6'

      "U+D6F7 returns 9990"
      '9990'
      (nwang) -> nwang.sf3 '\uD6F7'

      "U+D6F8 returns 10000"
      '10000'
      (nwang) -> nwang.sf3 '\uD6F8'


    ]



