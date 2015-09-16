3-1-04 `item.edit()`
====================


    tudor.add [
      "3-1-04 `item.edit()`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "The method is a function and returns an object"


      "`item.edit()` is a function"
      ªF
      (oo3d, item) -> item.edit

      "`item.edit()` returns an object"
      ªO
      (oo3d, item) -> item.edit()


      "`item.edit('i 4 mT 1 0 0 0 ... t 0 0 0')` returns an object"
      ªO
      (oo3d, item) -> item.edit "i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0"


      "`item.rX` is a number"
      ªN
      (oo3d, item) -> item.rX

      "`item.rY` is a number"
      ªN
      (oo3d, item) -> item.rY

      "`item.rZ` is a number"
      ªN
      (oo3d, item) -> item.rZ

      "`item.sX` is a number"
      ªN
      (oo3d, item) -> item.sX

      "`item.sY` is a number"
      ªN
      (oo3d, item) -> item.sY

      "`item.sZ` is a number"
      ªN
      (oo3d, item) -> item.sZ

      "`item.tX` is a number"
      ªN
      (oo3d, item) -> item.tX

      "`item.tY` is a number"
      ªN
      (oo3d, item) -> item.tY

      "`item.tZ` is a number"
      ªN
      (oo3d, item) -> item.tZ




      "Ensure private functions cannot be accessed"
      tudor.equal


      "`xx()` cannot be accessed"
      ªU
      (oo3d, item) -> typeof xx





      "`set` argument exceptions"
      tudor.throw


      "`set` cannot be a Date object"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        Optional `set` is date not string|object"""
      (oo3d, item) -> item.edit new Date

      "`set` cannot be the string 'NOPE!'"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        Optional `set` is string but not 'reset' or log|nwang format"""
      (oo3d, item) -> item.edit 'NOPE!'

      "`set` cannot be an empty string"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        Optional `set` is string but not 'reset' or log|nwang format"""
      (oo3d, item) -> item.edit ''


      "An object passed to the `set` argument must not must not change `item.index` to a boolean"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `this.index` cannot be altered by `set.index`"""
      (oo3d, item) -> item.edit { index:true }

      "An object passed to the `set` argument must not must not change `item.index` to a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `this.index` cannot be altered by `set.index`"""
      (oo3d, item) -> item.edit { index:1234 }

      "An `sY` property passed to the `set` argument must be a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set.sY` is array not number"""
      (oo3d, item) -> item.edit { rX:1, sY:['NOPE!'], tZ:3 }

      "A `tX` property passed to the `set` argument must not be NaN"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set.tX` is NaN"""
      (oo3d, item) -> item.edit { rX:1, tX:NaN, tZ:3 }

      "An `mT` property passed to the `set` argument must be Float32Array|array"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set.TtM` is object not array|*Array"""
      (oo3d, item) -> item.edit { mT:{} }

      "An `mT` property passed to the `set` argument must contain 16 values"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set.TtM` has 17 elements not 16"""
      (oo3d, item) -> item.edit { mT:[1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7] }


      "An 'nwang' string passed to the `set` argument must not be 8 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set` appears to be 'nwang' but is 8 characters"""
      (oo3d, item) -> item.edit '솆셢쵇솆밄첀솆밄'

      "An 'nwang' string passed to the `set` argument must not be 10 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set` appears to be 'nwang' but is 10 characters"""
      (oo3d, item) -> item.edit '솆셢쵇솆밄첀솆밄첀첀'

      "An 'nwang' string passed to the `set` argument must be valid nwang"
      """
      /nwang/src/class-main.litcoffee:Main:sf3()
        `x` codepoint 102 < 44032"""
      (oo3d, item) -> item.edit '솆셢쵇솆밄foo첀'

      "An 'nwang' string passed to the `set` argument must not change `item.index`"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `this.index` cannot be altered by passing `set` an 'nwang'"""
      (oo3d, item) -> item.edit '솆솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'


      "A 9-value 'log' string passed to the `set` argument must only contain numbers"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set` appears to be 9-char 'log' with non-numeric values"""
      (oo3d, item) -> item.edit 'r A B C s foo bar baz t 7 8 9'

      "A 16-value 'log' string passed to the `set` argument must only contain numbers"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `set` appears to be 26-char 'log' with non-numeric values"""
      (oo3d, item) -> item.edit 'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r A B C s foo bar baz t 7 8 9'

      "A 'log' string passed to the `set` argument must not change `item.index`"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `this.index` cannot be altered by passing `set` a 'log'"""
      (oo3d, item) -> item.edit 'i 12345 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 1 2 3 s 4 5 6 t 7 8 9'




      "`delta` argument exceptions"
      tudor.throw


      "`delta` cannot be the Math object"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        Optional `delta` is math not string|object"""
      (oo3d, item) -> item.edit null, Math

      "`delta` cannot be the string 'NOPE!'"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        Optional `delta` is a string, but not 'log|nwang' format"""
      (oo3d, item) -> item.edit null, 'NOPE!'

      "`delta` cannot be an empty string"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        Optional `delta` is a string, but not 'log|nwang' format"""
      (oo3d, item) -> item.edit null, ''


      "An `rX` property passed to the `delta` argument must be a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `delta.rX` is string not number"""
      (oo3d, item) -> item.edit null, { rX:'22' }

      "A `tZ` property passed to the `set` argument must not be NaN"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `delta.tZ` is NaN"""
      (oo3d, item) -> item.edit null, { rX:Math.PI, tX:-44.3, tZ:NaN }


      "An 'nwang' string passed to the `delta` argument must not be 8 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `delta` appears to be 'nwang' but is 8 characters"""
      (oo3d, item) -> item.edit null, '솆셢쵇솆밄첀솆밄'

      "An 'nwang' string passed to the `delta` argument must not be 26 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `delta` appears to be 'nwang' but is 26 characters"""
      (oo3d, item) -> item.edit null, '솆솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'

      "An 'nwang' string passed to the `delta` argument must be valid nwang"
      """
      /nwang/src/class-main.litcoffee:Main:sf3()
        `x` codepoint 102 < 44032"""
      (oo3d, item) -> item.edit null, '셼셼셼죨죨foo셼'


      "A 'log' string passed to the `delta` argument must only contain numbers"
      """
      /oo3d/src/item/base-item.litcoffee Item#4:edit()
        `delta` appears to be 9-char 'log' with non-numeric values"""
      (oo3d, item) -> item.edit null, 'r 88 77 66 s foo bar baz t A Z 9'




      "Noop ways of calling `item.edit()`"
      tudor.equal


      "No arguments"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit()
        item.read 'log'

      "Pass null to the `set` and `delta` arguments"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit null, null
        item.read 'log'

      "Pass undefined to the `set` and `delta` arguments"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit undefined, undefined
        item.read 'log'

      "Pass empty object to the `set` argument"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit {}
        item.read 'log'

      "Pass empty object to the `delta` argument"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit undefined, {}
        item.read 'log'

      "Pass empty objects to the `set` and `delta` arguments"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit {}, {}
        item.read 'log'




      "Pass an object to the `set` argument"


      "Pass a complete object to the `set` argument"
      'i 4 mT 1 2 2 2 2 1 3 3 3 3 1 4 4 4 4 1 r 1 2 3 s 4 5 6 t 7 8 9'
      (oo3d, item) ->
        item.edit { index:4, mT:[1,2,2,2,2,1,3,3,3,3,1,4,4,4,4,1], rX:1, rY:2, rZ:3, sX:4, sY:5, sZ:6, tX:7, tY:8, tZ:9 }
        item.read 'log'

      "Pass a partial object to the `set` argument, which includes `mT`"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 1 2 3 s 4 5 6 t 44 8 9'
      (oo3d, item) ->
        item.edit { mT:[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1], tX:44 }
        item.read 'log'

      "Pass a partial object to the `set` argument, which does not include `mT`"
      'i 4 mT 1.6479289531707764 -2.724970817565918 2.420509099960327 0 0.29363322257995605 -3.2143642902374268 -3.818591594696045 0 5.455784797668457 2.10105299949646 -1.3490705490112305 0 44 55 66 1 r 1 2 3 s 4 5 6 t 44 55 66'
      (oo3d, item) ->
        item.edit { tY:55, tZ:66 }
        item.read 'log'

      "Random properties are ignored"
      'i 4 mT 1.6479289531707764 -2.724970817565918 2.420509099960327 0 0.29363322257995605 -3.2143642902374268 -3.818591594696045 0 5.455784797668457 2.10105299949646 -1.3490705490112305 0 44 55 100 1 r 1 2 3 s 4 5 6 t 44 55 100'
      (oo3d, item) ->
        item.edit { foo:'IGNORED!', bar:'IGNORED!', tZ:100 }
        item.read 'log'

      "An `mT` property passed to the `set` argument can contain non-numeric values (will become NaN)"
      "i 4 mT 1 2 3 4 5 6 7 8 9 NaN 1 2 3 4 5 6 r 1 2 3 s 4 5 6 t 44 55 100"
      (oo3d, item) ->
        item.edit { mT:[1,2,3,4,5,6,7,8,9,'ten',1,2,3,4,5,6] }
        item.read 'log'

      "An `mT` property passed to the `set` argument can be UInt8Array"
      "i 4 mT 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 r 1 2 3 s 4 5 6 t 44 55 100"
      (oo3d, item) ->
        item.edit { mT:new Uint8Array [8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8] }
        item.read 'log'




      "Pass an 'nwang' string to the `set` argument"


      "Pass a 26-value 'nwang' string to the `set` argument"
      "i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0.001 -0.0026 31.9 s 0.001 -0.5 12 t 0.001 -0.5 12"
      (oo3d, item) ->
        item.edit '쨔죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨솆셢쵇솆밄첀솆밄첀'
        item.read 'log'

      "Pass a 9-value 'nwang' string to the `set` argument"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit '셼셼셼죨죨죨셼셼셼'
        item.read 'log'




      "Pass a 'log' string to the `set` argument"


      "Pass a 26-value 'log' string to the `set` argument, which resets the Item"
      'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit 'i 4 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
        item.read 'log'

      "Note that an inconsistent 26-value 'log' should be accepted without complaint!"
      'i 4 mT 1 2 3 4 5 6 7 8 9 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
      (oo3d, item) ->
        item.edit 'i 4 mT 1 2 3 4 5 6 7 8 9 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0'
        item.read 'log'

      "Pass a 9-value 'log' string to the `set` argument"
      'i 4 mT -0.6581568121910095 -1.7472580671310425 5.7020978927612305 0 0.4779578745365143 -4.773890972137451 -1.4076658487319946 0 3.957432985305786 0.23985300958156586 0.5302779078483582 0 3 2 1 1 r 9 8 7 s 6 5 4 t 3 2 1'
      (oo3d, item) ->
        item.edit 'r 9 8 7 s 6 5 4 t 3 2 1'
        item.read 'log'




      "Pass an object to the `delta` argument"


      "Pass a 'unity' 9-value object to the `delta` argument"
      'i 4 mT -0.6581568121910095 -1.7472580671310425 5.7020978927612305 0 0.4779578745365143 -4.773890972137451 -1.4076658487319946 0 3.957432985305786 0.23985300958156586 0.5302779078483582 0 3 2 1 1 r 9 8 7 s 6 5 4 t 3 2 1'
      (oo3d, item) ->
        item.edit null, { rX:0, rY:0, rZ:0, sX:1, sY:1, sZ:1, tX:0, tY:0, tZ:0 }
        item.read 'log'

      "Pass a transforming 9-value object to the `delta` argument"
      'i 4 mT 25.574983596801758 22.437387466430664 -33.85976791381836 0 -29.616554260253906 9.995354652404785 -15.746511459350586 0 -0.2124314159154892 20.078948974609375 13.144987106323242 0 21 22 23 1 r 21 22 23 s 48 35 24 t 21 22 23'
      (oo3d, item) ->
        item.edit null, { rX:12, rY:14, rZ:16, sX:8, sY:7, sZ:6, tX:18, tY:20, tZ:22 }
        item.read 'log'

      "Pass a transforming 2-value object to the `delta` argument"
      'i 4 mT 25.574983596801758 -3.992623805999756 40.422508239746094 0 74.0413818359375 3.6715314388275146 -46.48271942138672 0 -0.2124314159154892 -23.895618438720703 -2.2258212566375732 0 21 22 23 1 r -479 22 23 s 48 -87.5 24 t 21 22 23'
      (oo3d, item) ->
        item.edit null, { rX:-500, sY:-2.5 }
        item.read 'log'




      "Pass an 'nwang' string to the `delta` argument"


      "Pass a 'unity' 9-value 'nwang' string to the `delta` argument"
      'i 4 mT 25.574983596801758 -3.992623805999756 40.422508239746094 0 74.0413818359375 3.6715314388275146 -46.48271942138672 0 -0.2124314159154892 -23.895618438720703 -2.2258212566375732 0 21 22 23 1 r -479 22 23 s 48 -87.5 24 t 21 22 23'
      (oo3d, item) ->
        item.edit null, '셼셼셼죨죨죨셼셼셼'
        item.read 'log'


      "Pass a transforming 9-value 'nwang' string to the `delta` argument"
      'i 4 mT 0 0 0 0 -18.84529685974121 -2.4989914894104004 39.695213317871094 0 0.00007556568016298115 -0.023954685777425766 -0.0014721800107508898 0 165 23 23.000999450683594 1 r -479.0315 21.988 35 s 0 44.0125 0.024 t 165 23 23.001'
      (oo3d, item) ->
        item.edit null, '쁁섄첀셼밁솆퀜죨솆'
        item.read 'log'


@todo `oT` set to 'rts'  
@todo `oT` set to 'srt'  


@todo test the special 'reset' value passed to `set`


    ];



