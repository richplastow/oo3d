Snap
====

#### Helpers for snapshots

Note that these functions will often be called 1000s of times per second, so 
they’re designed to run as fast as possible. That means they do no type or 
range checking, so it’s up to the implementing app to pass valid arguments. 




@todo describe

    snap = {}




Methods
-------


#### `r2Unit()`
- `r <number>`  an angle, in radians
- `<number>`    xx

Xx. 

    snap.r2Unit = (r) -> Math.round r * snap.RESOLUTION_R




#### `r2snap()`
- `r <number>`  an angle, in radians
- `<string>`    xx

Xx. 

    snap.r2snap = (r) ->

      P2 = Math.PI * 2 # 6.283185307179586

Ignore ‘windings’. That is, any complete rotations beyond the first 360°. 
@todo test ignore number of rotations

      r = r % P2

Normalize negative `r`. 
@todo test

      if 0 > r then r += P2

Round the value up or down to the nearest unit (a unit is one 64th of 10°). 

      u = Math.round r * snap.RESOLUTION_R

Return a single uppercase letter for certain commonly encountered angles. 

      c1 = snap.USUAL_R[u]
      if c1 then return c1

Otherwise, convert the unit to a pair of ascii characters, where `c1` is 0-9a-z,
and `c2` is 0-9a-zA-Z_- making 36 * 64 combinations.  
@todo use 60ths (minutes), not 64ths, which will avoid '_' and '-'

      uM36 = u % 36 # the remainder (modulo), when `u` is divided by 36
      c1 = "0123456789abcdefghijklmnopqrstuvwxyz"[uM36]
      c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[(u - uM36) / 36]
      '' + c1 + c2




#### `s2snap()`
- `s <number>`   the scale, from -9999 to 9999 @todo beyond 9999?
- `<string>`     xx

Xx. 

    snap.s2snap = (s) ->

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
        n = s * 1000000
      else if 0.01  > s # 0.0010000 to 0.0099999 => 1000 to 9999
        m = if neg then 'b' else 'o'
        n = s * 1000000
      else if 0.1   > s # 0.0100000 to 0.0999999 => 1000 to 9999
        m = if neg then 'c' else 'n'
        n = s *  100000
      else if 1     > s # 0.1000000 to 0.9999999 => 1000 to 9999
        m = if neg then 'd' else 'm'
        n = s *   10000
      else if 10    > s # 1.0000000 to 9.9999999 => 1000 to 9999
        m = if neg then 'e' else 'l'
        n = s *    1000
      else if 100   > s # 10.000000 to 99.999999 => 1000 to 9999
        m = if neg then 'f' else 'k'
        n = s *     100
      else if 1000  > s # 100.00000 to 999.99999 => 1000 to 9999
        m = if neg then 'g' else 'j'
        n = s *      10
      else if 10000 > s # 1000.0000 to 9999.9999 => 1000 to 9999
        m = if neg then 'h' else 'i'
        n = s
      else
        return 'Z' # signifies that `s` was 10000 or greater @todo better response?

Trim decimal places.  
@todo maybe `Math.round()` the value up or down instead?

      n = Math.floor n

Return a single uppercase letter for certain commonly encountered scales. 

      c1 = snap.USUAL_S[m + n]
      if c1 then return c1

Otherwise, convert `n` and `m` to a sequence of three ascii characters, where 
`c1` is a-z, and `c2` and `c3` are 0-9a-zA-Z_- making 36 * 64 * 64 combinations.

      nM64 = n % 64 # the remainder (modulo), when `n` is divided by 64
      c1 = m
      c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[nM64]
      c3 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[(n - nM64) / 64]
      #ª s, n, nM64, (n - nM64) / 64, '' + c1 + c2 + c3
      '' + c1 + c2 + c3




#### `t2snap()`
- `t <number>`   the translation, from -9999 to 9999 @todo beyond 9999?
- `<string>`     xx

Xx. 

    snap.t2snap = (t) ->

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
        n = t * 1000000
      else if 0.01  > t # 0.0010000 to 0.0099999 => 1000 to 9999
        m = if neg then 'b' else 'o'
        n = t * 1000000
      else if 0.1   > t # 0.0100000 to 0.0999999 => 1000 to 9999
        m = if neg then 'c' else 'n'
        n = t *  100000
      else if 1     > t # 0.1000000 to 0.9999999 => 1000 to 9999
        m = if neg then 'd' else 'm'
        n = t *   10000
      else if 10    > t # 1.0000000 to 9.9999999 => 1000 to 9999
        m = if neg then 'e' else 'l'
        n = t *    1000
      else if 100   > t # 10.000000 to 99.999999 => 1000 to 9999
        m = if neg then 'f' else 'k'
        n = t *     100
      else if 1000  > t # 100.00000 to 999.99999 => 1000 to 9999
        m = if neg then 'g' else 'j'
        n = t *      10
      else if 10000 > t # 1000.0000 to 9999.9999 => 1000 to 9999
        m = if neg then 'h' else 'i'
        n = t
      else
        return 'Z' # signifies that `s` was 10000 or greater @todo better response?

Trim decimal places.  
@todo maybe `Math.round()` the value up or down instead?

      n = Math.floor n

Return a single uppercase letter for certain commonly encountered translations. 

      c1 = snap.USUAL_T[m + n]
      if c1 then ª t, n, c1; return c1

Otherwise, convert `n` and `m` to a sequence of three ascii characters, where 
`c1` is a-z, and `c2` and `c3` are 0-9a-zA-Z_- making 36 * 64 * 64 combinations.

      nM64 = n % 64 # the remainder (modulo), when `n` is divided by 64
      c1 = m
      c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[nM64]
      c3 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[(n - nM64) / 64]
      ª t, n, nM64, (n - nM64) / 64, '' + c1 + c2 + c3
      '' + c1 + c2 + c3




Properties
----------


#### `RESOLUTION_R`
The maximum resolution of `r2snap()` and `snap2r()`, in radians. 

    snap.RESOLUTION_R = 1 / (Math.PI * 2 / 36 / 64) # 366.692988883726881
    #snap.RESOLUTION_R = 1 / (Math.PI * 2 / 36 / 60) # 343.774677078493951


#### `USUAL_R`
Xx. 

    snap.USUAL_R = (->
      PI = Math.PI
      USUAL_R = {}
      USUAL_R[0]                           = 'A' # 0°   0.0000000000000000    0
      USUAL_R[ snap.r2Unit PI / 6.0      ] = 'B' # 30°  0.5235987755982988  192
      USUAL_R[ snap.r2Unit PI / 4.0      ] = 'C' # 45°  0.7853981633974483  288
      USUAL_R[ snap.r2Unit PI / 3.0      ] = 'D' # 60°  1.0471975511965976  384
      USUAL_R[ snap.r2Unit PI * 0.5      ] = 'E' # 90°  1.5707963267948966  576
      USUAL_R[ snap.r2Unit PI / 1.5      ] = 'F' # 120° 2.0943951023931953  768
      USUAL_R[ snap.r2Unit PI * 0.75     ] = 'G' # 135° 2.3561944901923450  864
      USUAL_R[ snap.r2Unit PI / 1.2      ] = 'H' # 150° 2.6179938779914944  960
      USUAL_R[ snap.r2Unit PI            ] = 'I' # 180° 3.1415926535897930 1152
      USUAL_R[ snap.r2Unit PI / 6.0 + PI ] = 'J' # 210° 3.6651914291880920 1344
      USUAL_R[ snap.r2Unit PI / 4.0 + PI ] = 'K' # 225° 3.9269908169872414 1440
      USUAL_R[ snap.r2Unit PI / 3.0 + PI ] = 'L' # 240° 4.1887902047863905 1536
      USUAL_R[ snap.r2Unit PI * 1.5      ] = 'M' # 270° 4.7123889803846900 1728
      USUAL_R[ snap.r2Unit PI / 1.5 + PI ] = 'N' # 300° 5.2359877559829890 1920
      USUAL_R[ snap.r2Unit PI * 1.75     ] = 'O' # 315° 5.4977871437821380 2016
      USUAL_R[ snap.r2Unit PI / 1.2 + PI ] = 'P' # 330° 5.7595865315812870 2112
      USUAL_R[ snap.r2Unit PI * 2.0      ] = 'Q' # 360° 6.2831853071795860 2304
      USUAL_R)()


#### `USUAL_S`
Xx.  
@todo more of these

    snap.USUAL_S =
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


#### `USUAL_T`
Xx.  
@todo more of these

    snap.USUAL_T =
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


    #for i in [2300..2306]
    #  r = Math.PI * 2 * i / 2304
    #  snap.r2snap r

    #ª '---'

