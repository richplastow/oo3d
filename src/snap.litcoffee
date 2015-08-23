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
        if c1 then ª r, u, c1; return c1

Otherwise, convert the unit to a pair of ascii characters, where `c1` is 0-9a-z,
and `c2` is 0-9a-zA-Z_- making 36 * 64 combinations. 

        uM36 = u % 36 # the remainder (modulo), when `u` is divided by 36
        #ª u, uM36, (u - uM36) / 36
        c1 = "0123456789abcdefghijklmnopqrstuvwxyz"[uM36]
        c2 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"[(u - uM36) / 36]
        ª r, u, '' + c1 + c2
        '' + c1 + c2



Properties
----------


#### `R`
The maximum resolution of `r2snap()` and `snap2r()`, in radians. 

    snap.RESOLUTION_R = 1 / (Math.PI * 2 / 36 / 64) # 366.692988883726881


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



    #for i in [2300..2306]
    #  r = Math.PI * 2 * i / 2304
    #  snap.r2snap r

    #ª '---'
