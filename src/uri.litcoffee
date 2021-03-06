Uri
===

#### Helpers for encoding Oo3d objects to URI-compatible strings, and back again

Note that these functions will often be called 1000s of times per second, so 
they’re designed to run as fast as possible. That means they do no type or 
range checking, so it’s up to the implementing app to pass valid arguments. 




@todo describe

    uri = {}




Methods
-------


#### `r2Tenmin()`
- `r <number>`  an angle, in radians
- `<integer>`   the angle converted to tenmins

Xx. 

    uri.r2Tenmin = (r) -> Math.round r * uri.RESOLUTION_R




#### `tenmin2r()`
- `tenmin <number>`  an angle, in tenmins
- `<number>`         the angle converted to radians

Xx. 

    uri.tenmin2r = (r) -> r / uri.RESOLUTION_R




#### `r2uri()`
- `r <number>`  an angle, in radians
- `<string>`    xx

Xx. 

    uri.r2uri = (radians) ->

      PI2 = Math.PI * 2 # 6.283185307179586

Ignore ‘windings’. That is, any complete rotations beyond the first 360°. 
@todo test ignore number of rotations

      radians = radians % PI2

Normalize negative `radians`. 
@todo test

      if 0 > radians then radians += PI2

Round the value up or down to the nearest `tenmin` (a tenmin is one 6th of 1°). 

      tenmin = uri.r2Tenmin radians

Return a single uppercase letter for certain commonly encountered angles. 

      c1 = uri.USUAL_R2URI[tenmin]
      if c1 then return c1

Otherwise, convert the tenmin to a pair of ascii characters, where `c1` is 
0-9a-z, and `c2` is 0-9a-zA-X, making 36 * 60 combinations. 

      c1i = tenmin % 36         # the modulo (remainder), when divided by 36
      c2i = (tenmin - c1i) / 36 # the number of entire 36s which fit in tenmin
      c1 = "0123456789abcdefghijklmnopqrstuvwxyz"[c1i]
      c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWX"[c2i]
      #ª 'uri2r(' + radians + ')', c1i, c2i, tenmin, c1 + c2
      '' + c1 + c2




#### `s2uri()`
- `s <number>`   the scale, from -9999 to 9999 @todo beyond 9999?
- `<string>`     xx

Xx. 

    uri.s2uri = (s) ->

Record and remove the sign of a negative number. 

      if 0 > s
        neg = true
        s = Math.abs s

Shortcut for zero. 

      if 0.0001 > s then return 'A' # signifies zero

Normalize the scale to fit within the range `0` to `9999`, and record a code 
for the multiplier. 

      if      0.001 > s # 0.0001000 to 0.0009999 => 1000 to 9999
        m = if neg then 'a' else 'p'
        n = s * 10000000
      else if 0.01  > s # 0.0010000 to 0.0099999 => 1000 to 9999
        m = if neg then 'b' else 'o'
        n = s *  1000000
      else if 0.1   > s # 0.0100000 to 0.0999999 => 1000 to 9999
        m = if neg then 'c' else 'n'
        n = s *   100000
      else if 1     > s # 0.1000000 to 0.9999999 => 1000 to 9999
        m = if neg then 'd' else 'm'
        n = s *    10000
      else if 10    > s # 1.0000000 to 9.9999999 => 1000 to 9999
        m = if neg then 'e' else 'l'
        n = s *     1000
      else if 100   > s # 10.000000 to 99.999999 => 1000 to 9999
        m = if neg then 'f' else 'k'
        n = s *      100
      else if 1000  > s # 100.00000 to 999.99999 => 1000 to 9999
        m = if neg then 'g' else 'j'
        n = s *       10
      else if 10000 > s # 1000.0000 to 9999.9999 => 1000 to 9999
        m = if neg then 'h' else 'i'
        n = s
      else
        return 'Z' # signifies that `s` was 10000 or greater @todo better response?

Trim decimal places.  
@todo maybe `Math.round()` the value up or down instead?

      n = n / 4 #@todo remove this thinning
      n = Math.floor n

Return a single uppercase letter for certain commonly encountered scales. 

      c1 = uri.USUAL_S2URI[m + n]
      if c1 then return c1

Otherwise, convert `n` and `m` to a sequence of three ascii characters, where 
`c1` is 0-9a-z, and `c2/c3` are 0-9a-zA-Z_- making 36 * 64 * 64 combinations.

      nM64 = n % 64 # the remainder (modulo), when `n` is divided by 64
      c1 = m
      c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[nM64]
      c3 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[(n - nM64) / 64]
      #ª 's2uri(' + s + ')', n, nM64, (n - nM64) / 64, '' + c1 + c2 + c3
      if ªU == typeof c1 or ªU == typeof c2 or ªU == typeof c3
        ª 'UNDEFINED RESULT s2uri(' + s + ')', n, nM64, (n - nM64) / 64, '' + c1 + c2 + c3
      c1 + c2 + c3




#### `t2uri()`
- `t <number>`   the translation, from -9999 to 9999 @todo beyond 9999?
- `<string>`     xx

Xx. 

    uri.t2uri = (t) ->

Record and remove the sign of a negative number. 

      if 0 > t
        neg = true
        t = Math.abs t

Shortcut for zero. 

      if 0.0001 > t then return 'A' # signifies zero

Normalize the scale to fit within the range `0` to `9999`, and record a code 
for the multiplier. 

      if      0.001 > t # 0.0001000 to 0.0009999 => 1000 to 9999
        m = if neg then 'a' else 'p'
        n = t * 10000000
      else if 0.01  > t # 0.0010000 to 0.0099999 => 1000 to 9999
        m = if neg then 'b' else 'o'
        n = t *  1000000
      else if 0.1   > t # 0.0100000 to 0.0999999 => 1000 to 9999
        m = if neg then 'c' else 'n'
        n = t *   100000
      else if 1     > t # 0.1000000 to 0.9999999 => 1000 to 9999
        m = if neg then 'd' else 'm'
        n = t *    10000
      else if 10    > t # 1.0000000 to 9.9999999 => 1000 to 9999
        m = if neg then 'e' else 'l'
        n = t *     1000
      else if 100   > t # 10.000000 to 99.999999 => 1000 to 9999
        m = if neg then 'f' else 'k'
        n = t *      100
      else if 1000  > t # 100.00000 to 999.99999 => 1000 to 9999
        m = if neg then 'g' else 'j'
        n = t *       10
      else if 10000 > t # 1000.0000 to 9999.9999 => 1000 to 9999
        m = if neg then 'h' else 'i'
        n = t
      else
        return 'Z' # signifies that `s` was 10000 or greater @todo better response?

Trim decimal places.  
@todo maybe `Math.round()` the value up or down instead?

      n = n / 4 #@todo remove this thinning
      n = Math.floor n

Return a single uppercase letter for certain commonly encountered translations. 

      c1 = uri.USUAL_T2URI[m + n]
      if c1 then return c1

Otherwise, convert `n` and `m` to a sequence of three ascii characters, where 
`c1` is 0-9a-z, and `c2/c3` are 0-9a-zA-Z_- making 36 * 64 * 64 combinations.

      nM64 = n % 64 # the remainder (modulo), when `n` is divided by 64
      c1 = m
      c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[nM64]
      c3 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[(n - nM64) / 64]
      #ª 't2uri(' + t + ')', n, nM64, (n - nM64) / 64, '' + c1 + c2 + c3
      if ªU == typeof c1 or ªU == typeof c2 or ªU == typeof c3
        ª 'UNDEFINED RESULT t2uri(' + t + ')', n, nM64, (n - nM64) / 64, '' + c1 + c2 + c3
      c1 + c2 + c3




#### `uri2r()`
- `str <string>`  xx
- `<number>`      the angle, in radians

Xx. 

    uri.uri2r = (str) ->

A single uppercase letter stands for a commonly encountered rotation. 

      usual = uri.USUAL_URI2R[str]
      if ªN == typeof usual then return uri.tenmin2r usual

Otherwise, `str` should be a pair of ascii characters, where `c1` is 0-9a-z, 
and `c2` is 0-9a-zA-X, making 36 * 60 combinations, representing a `tenmin`. 

      c1 = uri.B64DECODE[ str[0] ]
      c2 = uri.B64DECODE[ str[1] ]

      #ª 'uri2r(' + str + ')', c1, c2, c1 * 60 + c2, uri.tenmin2r c1 * 60 + c2
      uri.tenmin2r c1 * 60 + c2




#### `uri2s()`
- `str <string>`  xx
- `<number>`      the scale

Xx. 

    uri.uri2s = (str) ->

A single uppercase letter stands for a commonly encountered scale. 

      usual = uri.USUAL_URI2S[str]
      if ªN == typeof usual then return usual

Otherwise, `str` should be a sequence of three ascii characters, where 
`c1` is a-z, and `c2` and `c3` are 0-9a-zA-Z_- making 36 * 64 * 64 combinations.

      c1 = uri.MULTIPLIER[ str[0] ]
      c2 = uri.B64DECODE[  str[1] ]
      c3 = uri.B64DECODE[  str[2] ]

      #ª 'uri2s(' + str + ')', c1, c2, c3, c1 * (c2 + c3 * 64)
      c1 * (c2 + c3 * 64 * 4) #@todo remove the `* 4` thinning




#### `uri2t()`
- `str <string>`  xx
- `<number>`      the translation

Xx. 

    uri.uri2t = (str) ->

A single uppercase letter stands for a commonly encountered translation. 

      usual = uri.USUAL_URI2T[str]
      if ªN == typeof usual then return usual

Otherwise, `str` should be a sequence of three ascii characters, where 
`c1` is a-z, and `c2` and `c3` are 0-9a-zA-Z_- making 36 * 64 * 64 combinations.

      c1 = uri.MULTIPLIER[ str[0] ]
      c2 = uri.B64DECODE[  str[1] ]
      c3 = uri.B64DECODE[  str[2] ]

      #ª 'uri2t(' + str + ')', c1, c2, c3, c1 * (c2 + c3 * 64)
      c1 * (c2 + c3 * 64 * 4) #@todo remove the `* 4` thinning




Properties
----------


#### `RESOLUTION_R`
The maximum resolution of `r2uri()` and `uri2r()`, in radians. 

    uri.RESOLUTION_R = 1 / (Math.PI * 2 / 36 / 60) # 343.774677078493951


#### `USUAL_R2URI`
Xx.  
@todo replace with hardcoded values?

    uri.USUAL_R2URI = (->
      PI = Math.PI
      out = {}
      out[0]                            = 'A' # 0°   0.0000000000000000    0
      out[ uri.r2Tenmin PI / 6.0      ] = 'B' # 30°  0.5235987755982988  180
      out[ uri.r2Tenmin PI / 4.0      ] = 'C' # 45°  0.7853981633974483  270
      out[ uri.r2Tenmin PI / 3.0      ] = 'D' # 60°  1.0471975511965976  384
      out[ uri.r2Tenmin PI * 0.5      ] = 'E' # 90°  1.5707963267948966  360
      out[ uri.r2Tenmin PI / 1.5      ] = 'F' # 120° 2.0943951023931953  720
      out[ uri.r2Tenmin PI * 0.75     ] = 'G' # 135° 2.3561944901923450  810
      out[ uri.r2Tenmin PI / 1.2      ] = 'H' # 150° 2.6179938779914944  900
      out[ uri.r2Tenmin PI            ] = 'I' # 180° 3.1415926535897930 1080
      out[ uri.r2Tenmin PI / 6.0 + PI ] = 'J' # 210° 3.6651914291880920 1260
      out[ uri.r2Tenmin PI / 4.0 + PI ] = 'K' # 225° 3.9269908169872414 1350
      out[ uri.r2Tenmin PI / 3.0 + PI ] = 'L' # 240° 4.1887902047863905 1440
      out[ uri.r2Tenmin PI * 1.5      ] = 'M' # 270° 4.7123889803846900 1620
      out[ uri.r2Tenmin PI / 1.5 + PI ] = 'N' # 300° 5.2359877559829890 1800
      out[ uri.r2Tenmin PI * 1.75     ] = 'O' # 315° 5.4977871437821380 1890
      out[ uri.r2Tenmin PI / 1.2 + PI ] = 'P' # 330° 5.7595865315812870 1980
      out[ uri.r2Tenmin PI * 2.0      ] = 'Q' # 360° 6.2831853071795860 2160
      out)()


#### `USUAL_URI2R`
Xx.  

    uri.USUAL_URI2R = (->
      out = {}
      out[val] = +key for key, val of uri.USUAL_R2URI
      out)()


#### `USUAL_S2URI`
Xx.  
@todo more of these

    uri.USUAL_S2URI =
      d1250: 'C' # -0.125
      d2500: 'D' # -0.25
      d5000: 'E' # -0.5
      e1000: 'F' # -1
      e2000: 'G' # -2
      e4000: 'H' # -4
      e8000: 'I' # -8

      m1250: 'R' # +0.125
      m2500: 'S' # +0.25
      m5000: 'T' # +0.5
      l1000: 'U' # +1 (unity)
      l2000: 'V' # +2
      l4000: 'W' # +4
      l8000: 'X' # +8


#### `USUAL_URI2S`
Xx.  

    uri.USUAL_URI2S =
      A:  0

      C: -0.125
      D: -0.25
      E: -0.5
      F: -1
      G: -2
      H: -4
      I: -8

      R:  0.125
      S:  0.25
      T:  0.5
      U:  1
      V:  2
      W:  4
      X:  8

      Z:  10000


#### `USUAL_T2URI`
Xx.  
@todo more of these

    uri.USUAL_T2URI =
      d1250: 'C' # -0.125
      d2500: 'D' # -0.25
      d5000: 'E' # -0.5
      e1000: 'F' # -1
      e2000: 'G' # -2
      e4000: 'H' # -4
      e8000: 'I' # -8

      m1250: 'R' # +0.125
      m2500: 'S' # +0.25
      m5000: 'T' # +0.5
      l1000: 'U' # +1 (unity)
      l2000: 'V' # +2
      l4000: 'W' # +4
      l8000: 'X' # +8


#### `USUAL_URI2T`
Xx.  

    uri.USUAL_URI2T =
      A:  0

      C: -0.125
      D: -0.25
      E: -0.5
      F: -1
      G: -2
      H: -4
      I: -8

      R:  0.125
      S:  0.25
      T:  0.5
      U:  1
      V:  2
      W:  4
      X:  8

      Z:  10000


#### `MULTIPLIER`
Xx.  

    uri.MULTIPLIER =
      a: -1 / 10000000
      b: -1 /  1000000
      c: -1 /   100000
      d: -1 /    10000
      e: -1 /     1000
      f: -1 /      100
      g: -1 /       10
      h: -1

      p:  1 / 10000000
      o:  1 /  1000000
      n:  1 /   100000
      m:  1 /    10000
      l:  1 /     1000
      k:  1 /      100
      j:  1 /       10
      i:  1


#### `B64DECODE`
Xx.  

    uri.B64DECODE = (->
      out = {}
      b64 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
      out[ b64[i] ] = i for i in [0..63]
      out)()



    #for i in [2300..2306]
    #  r = Math.PI * 2 * i / 2304
    #  uri.r2uri r

    #ª '---'



