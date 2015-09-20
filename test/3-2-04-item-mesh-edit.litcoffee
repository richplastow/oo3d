3-2-04 `Item.Mesh:edit()`
=========================


    tudor.add [
      "3-2-04 `Item.Mesh:edit()`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "(Directly create an Item.Mesh instance)"
      (oo3d) ->
        bufferPositionI     = oo3d.add('Buffer.Position', { data: [] })
        bufferColorI        = oo3d.add('Buffer.Color'   , { data: [] })
        bufferMorePositionI = oo3d.add('Buffer.Position', { data: [1,1,1] })
        bufferMoreColorI    = oo3d.add('Buffer.Color'   , { data: [1,1,1,1] })
        [(new Item.Mesh oo3d, 0), bufferPositionI, bufferColorI, bufferMorePositionI, bufferMoreColorI]




      "The method is a function and returns an object"


      "`mesh.edit()` is a function"
      ªF
      (mesh) -> mesh.edit

      "`mesh.edit()` returns an object"
      ªO
      (mesh) -> mesh.edit()


      "`mesh.edit('i 0 mT 1 0 0 0 ... t 0 0 0 bP 0 bC 1')` returns an object"
      ªO
      (mesh) -> mesh.edit "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1"


      "`mesh.rX` is a number"
      ªN
      (mesh) -> mesh.rX

      "`mesh.rY` is a number"
      ªN
      (mesh) -> mesh.rY

      "`mesh.rZ` is a number"
      ªN
      (mesh) -> mesh.rZ

      "`mesh.sX` is a number"
      ªN
      (mesh) -> mesh.sX

      "`mesh.sY` is a number"
      ªN
      (mesh) -> mesh.sY

      "`mesh.sZ` is a number"
      ªN
      (mesh) -> mesh.sZ

      "`mesh.tX` is a number"
      ªN
      (mesh) -> mesh.tX

      "`mesh.tY` is a number"
      ªN
      (mesh) -> mesh.tY

      "`mesh.tZ` is a number"
      ªN
      (mesh) -> mesh.tZ




      "Ensure private functions cannot be accessed"
      tudor.equal


      "`xx()` cannot be accessed"
      ªU
      (mesh) -> typeof xx





      "`set` argument exceptions"
      tudor.throw


      "`set` cannot be a Date object"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        Optional `set` is date not string|object"""
      (mesh) -> mesh.edit new Date

      "`set` cannot be the string 'NOPE!'"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        Optional `set` is string but not 'reset' or log|nwang format"""
      (mesh) -> mesh.edit 'NOPE!'

      "`set` cannot be an empty string"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        Optional `set` is string but not 'reset' or log|nwang format"""
      (mesh) -> mesh.edit ''


      "An object passed to the `set` argument must not must not change `item.index` to a boolean"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `this.index` cannot be altered by `set.index`"""
      (mesh) -> mesh.edit { index:true }

      "An object passed to the `set` argument must not must not change `item.index` to a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `this.index` cannot be altered by `set.index`"""
      (mesh) -> mesh.edit { index:1234 }

      "An `sY` property passed to the `set` argument must be a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set.sY` is array not number"""
      (mesh) -> mesh.edit { rX:1, sY:['NOPE!'], tZ:3 }

      "A `tX` property passed to the `set` argument must not be NaN"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set.tX` is NaN"""
      (mesh) -> mesh.edit { rX:1, tX:NaN, tZ:3 }

      "An `mT` property passed to the `set` argument must be Float32Array|array"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set.TtM` is object not array|*Array"""
      (mesh) -> mesh.edit { mT:{} }

      "An `mT` property passed to the `set` argument must contain 16 values"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set.TtM` has 17 elements not 16"""
      (mesh) -> mesh.edit { mT:[1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7] }

Item.Mesh set object bpi. 

      "A `bpi` property passed to the `set` argument must not be a string"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bpi` is string not number"""
      (mesh) -> mesh.edit { bpi:'foo' }

      "A `bpi` property passed to the `set` argument must not be -ve"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bpi` is -1 not 0 or a +ve int < 2^53"""
      (mesh) -> mesh.edit { bpi:-1 }

      "A `bpi` property passed to the `set` argument must refer to an instance in `main._all`"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bpi` no such instance `main._all[123]`"""
      (mesh) -> mesh.edit { bpi:123 }

      "A `bpi` property passed to the `set` argument must refer to a Buffer.Position instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bpi` refs Buffer.Color at `main._all[3]`"""
      (mesh) -> mesh.edit { bpi:3 }

      "A `bpi` property passed to the `set` argument must match the mesh’s Buffer.Color count"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        `set.bpi` mismatches the mesh’s Buffer.Color#1"""
      (mesh, bufferPositionI, bufferColorI, bufferMorePositionI) ->
        mesh.edit { bpi:bufferMorePositionI }

Item.Mesh set object bci. 

      "A `bci` property passed to the `set` argument must not be an array"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bci` is array not number"""
      (mesh) -> mesh.edit { bci:[123] }

      "A `bci` property passed to the `set` argument must not be -ve"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bci` is 9007199254741092 not 0 or a +ve int < 2^53"""
      (mesh) -> mesh.edit { bci:ªMAX+100 }

      "A `bci` property passed to the `set` argument must refer to an instance in `main._all`"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bci` no such instance `main._all[444]`"""
      (mesh) -> mesh.edit { bci:444 }

      "A `bci` property passed to the `set` argument must refer to a Buffer.Color instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Optional `set.bci` refs Buffer.Position at `main._all[0]`"""
      (mesh) -> mesh.edit { bci:0 }

      "A `bci` property passed to the `set` argument must match the mesh’s Buffer.Position count"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        `set.bci` mismatches the mesh’s Buffer.Position#0"""
      (mesh, bufferPositionI, bufferColorI, bufferMorePositionI, bufferMoreColorI) ->
        mesh.edit { bci:bufferMoreColorI }

      "`bpi` and `bci` properties passed to the `set` argument must match each other"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        `set.bpi` mismatches `set.bci`"""
      (mesh, bufferPositionI, bufferColorI, bufferMorePositionI) ->
        mesh.edit { bpi:bufferMorePositionI, bci:bufferColorI }

Item set nwang. 

      "An 'nwang' string passed to the `set` argument must not be 8 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set` appears to be 'nwang' but is 8 characters"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄'

      "An 'nwang' string passed to the `set` argument must not be 10 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set` appears to be 'nwang' but is 10 characters"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀첀'

      "An 'nwang' string passed to the `set` argument must be valid nwang"
      """
      /nwang/src/class-main.litcoffee:Main:sf3()
        `x` codepoint 102 < 44032"""
      (mesh) -> mesh.edit '솆셢쵇솆밄foo첀'

      "An 'nwang' string passed to the `set` argument must not change `item.index`"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `this.index` cannot be altered by passing `set` an 'nwang'"""
      (mesh) -> mesh.edit '솆솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'

Item.Mesh set nwang bpi. 

      "An 11-char 'nwang' string’s `bpi` value must not be fractional"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Nwang `bpi` value is 0.001 not 0 or a +ve int"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀솆첀'

      "An 11-char 'nwang' string’s `bpi` value must refer to an instance in `main._all`"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Nwang `bpi` no such instance `main._all[12]`"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀첀첀'

      "An 11-char 'nwang' string’s `bpi` value must refer to a Buffer.Position instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Nwang `bpi` refs Item.Mesh at `main._all[4]`"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀쨔첀'

      "An 11-char 'nwang' string’s `bpi` count must match its `bci` count"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        `set.bpi` mismatches `set.bci`"""
      (mesh, bufferPositionI, bufferColorI, bufferMorePositionI) ->
        mesh.edit '솆셢쵇솆밄첀솆밄첀' + mesh.main.nwang.sf3(bufferMorePositionI) + '죨'

Item.Mesh set nwang bci. 

      "An 11-char 'nwang' string’s `bci` value must not be fractional"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Nwang `bci` value is 0.001 not 0 or a +ve int"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀셼솆'

      "An 11-char 'nwang' string’s `bci` value must refer to an instance in `main._all`"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Nwang `bci` no such instance `main._all[12]`"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀셼첀'

      "An 11-char 'nwang' string’s `bci` value must refer to a Buffer.Color instance"
      """
      /oo3d/src/item/class-item-mesh.litcoffee Item.Mesh#0:edit()
        Nwang `bci` refs Item.Mesh at `main._all[4]`"""
      (mesh) -> mesh.edit '솆셢쵇솆밄첀솆밄첀셼쨔'

Item set log. 

      "A 9-value 'log' string passed to the `set` argument must only contain numbers"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set` appears to be 9-char 'log' with non-numeric values"""
      (mesh) -> mesh.edit 'r A B C s foo bar baz t 7 8 9'

      "A 16-value 'log' string passed to the `set` argument must only contain numbers"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `set` appears to be 26-char 'log' with non-numeric values"""
      (mesh) -> mesh.edit 'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r A B C s foo bar baz t 7 8 9'

      "A 'log' string passed to the `set` argument must not change `item.index`"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `this.index` cannot be altered by passing `set` a 'log'"""
      (mesh) -> mesh.edit 'i 12345 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 1 2 3 s 4 5 6 t 7 8 9'




      "`delta` argument exceptions"
      tudor.throw


      "`delta` cannot be the Math object"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        Optional `delta` is math not string|object"""
      (mesh) -> mesh.edit null, Math

      "`delta` cannot be the string 'NOPE!'"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        Optional `delta` is a string, but not 'log|nwang' format"""
      (mesh) -> mesh.edit null, 'NOPE!'

      "`delta` cannot be an empty string"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        Optional `delta` is a string, but not 'log|nwang' format"""
      (mesh) -> mesh.edit null, ''


      "An `rX` property passed to the `delta` argument must be a number"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `delta.rX` is string not number"""
      (mesh) -> mesh.edit null, { rX:'22' }

      "A `tZ` property passed to the `set` argument must not be NaN"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `delta.tZ` is NaN"""
      (mesh) -> mesh.edit null, { rX:Math.PI, tX:-44.3, tZ:NaN }


      "An 'nwang' string passed to the `delta` argument must not be 8 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `delta` appears to be 'nwang' but is 8 characters"""
      (mesh) -> mesh.edit null, '솆셢쵇솆밄첀솆밄'

      "An 'nwang' string passed to the `delta` argument must not be 26 characters"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `delta` appears to be 'nwang' but is 26 characters"""
      (mesh) -> mesh.edit null, '솆솅솁셼셼엺뱇셾셼쁁섄첀셼밁쑑퀜죨솆셢쵇솆밄첀솆밄첀'

      "An 'nwang' string passed to the `delta` argument must be valid nwang"
      """
      /nwang/src/class-main.litcoffee:Main:sf3()
        `x` codepoint 102 < 44032"""
      (mesh) -> mesh.edit null, '셼셼셼죨죨foo셼'


      "A 'log' string passed to the `delta` argument must only contain numbers"
      """
      /oo3d/src/item/base-item.litcoffee Item#0:edit()
        `delta` appears to be 9-char 'log' with non-numeric values"""
      (mesh) -> mesh.edit null, 'r 88 77 66 s foo bar baz t A Z 9'




      "Noop ways of calling `mesh.edit()`"
      tudor.equal


      "No arguments"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit()
        mesh.read 'log'

      "Pass null to the `set` and `delta` arguments"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit null, null
        mesh.read 'log'

      "Pass undefined to the `set` and `delta` arguments"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit undefined, undefined
        mesh.read 'log'

      "Pass empty object to the `set` argument"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit {}
        mesh.read 'log'

      "Pass empty object to the `delta` argument"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit undefined, {}
        mesh.read 'log'

      "Pass empty objects to the `set` and `delta` arguments"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit {}, {}
        mesh.read 'log'




      "Pass an object to the `set` argument"


      "Pass a complete object to the `set` argument"
      'i 0 mT 1 2 2 2 2 1 3 3 3 3 1 4 4 4 4 1 r 1 2 3 s 4 5 6 t 7 8 9 bP 0 bC 1'
      (mesh) ->
        mesh.edit { index:0, mT:[1,2,2,2,2,1,3,3,3,3,1,4,4,4,4,1], rX:1, rY:2, rZ:3, sX:4, sY:5, sZ:6, tX:7, tY:8, tZ:9, bpi:0, bci:1 }
        mesh.read 'log'

      "Pass a partial object to the `set` argument, which includes `mT`"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 1 2 3 s 4 5 6 t 44 8 9 bP 0 bC 1'
      (mesh) ->
        mesh.edit { mT:[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1], tX:44 }
        mesh.read 'log'

      "Pass a partial object to the `set` argument, which does not include `mT`"
      'i 0 mT 1.6479289531707764 -2.724970817565918 2.420509099960327 0 0.29363322257995605 -3.2143642902374268 -3.818591594696045 0 5.455784797668457 2.10105299949646 -1.3490705490112305 0 44 55 66 1 r 1 2 3 s 4 5 6 t 44 55 66 bP 0 bC 1'
      (mesh) ->
        mesh.edit { tY:55, tZ:66 }
        mesh.read 'log'

      "Random properties are ignored"
      'i 0 mT 1.6479289531707764 -2.724970817565918 2.420509099960327 0 0.29363322257995605 -3.2143642902374268 -3.818591594696045 0 5.455784797668457 2.10105299949646 -1.3490705490112305 0 44 55 100 1 r 1 2 3 s 4 5 6 t 44 55 100 bP 0 bC 1'
      (mesh) ->
        mesh.edit { foo:'IGNORED!', bar:'IGNORED!', tZ:100 }
        mesh.read 'log'

      "An `mT` property passed to the `set` argument can contain non-numeric values (will become NaN)"
      "i 0 mT 1 2 3 4 5 6 7 8 9 NaN 1 2 3 4 5 6 r 1 2 3 s 4 5 6 t 44 55 100 bP 0 bC 1"
      (mesh) ->
        mesh.edit { mT:[1,2,3,4,5,6,7,8,9,'ten',1,2,3,4,5,6] }
        mesh.read 'log'

      "An `mT` property passed to the `set` argument can be UInt8Array"
      "i 0 mT 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 r 1 2 3 s 4 5 6 t 44 55 100 bP 0 bC 1"
      (mesh) ->
        mesh.edit { mT:new Uint8Array [8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8] }
        mesh.read 'log'

      "A `bP` property passed to the `set` argument changes the mesh’s Buffer.Position"
      "i 0 mT 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 r 1 2 3 s 4 5 6 t 44 55 100 bP 5 bC 1"
      (mesh, bufferPositionI) ->
        mesh.edit { bpi:bufferPositionI, mT:new Uint8Array [8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8] }
        mesh.read 'log'

      "A `bC` property passed to the `set` argument changes the mesh’s Buffer.Color"
      "i 0 mT 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 r 1 2 3 s 4 5 6 t 44 55 100 bP 5 bC 6"
      (mesh, bufferPositionI, bufferColorI) ->
        mesh.edit { bci:bufferColorI, mT:new Uint8Array [8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8] }
        mesh.read 'log'




      "Pass an 'nwang' string to the `set` argument"


      "Pass a 26-value 'nwang' string to the `set` argument"
      "i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0.001 -0.0026 31.9 s 0.001 -0.5 12 t 0.001 -0.5 12 bP 5 bC 6"
      (mesh) ->
        mesh.edit '셼죨셼셼셼셼죨셼셼셼셼죨셼셼셼셼죨솆셢쵇솆밄첀솆밄첀'
        mesh.read 'log'

      "Pass a 9-value 'nwang' string to the `set` argument"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 5 bC 6'
      (mesh) ->
        mesh.edit '셼셼셼죨죨죨셼셼셼'
        mesh.read 'log'

      "Pass an 11-value 'nwang' string to the `set` argument"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        sf3 = mesh.main.nwang.sf3
        mesh.edit '셼셼셼죨죨죨셼셼셼' + sf3(0) + sf3(1)
        mesh.read 'log'




      "Pass a 'log' string to the `set` argument"


      "Pass a 26-value 'log' string to the `set` argument, which resets the Item"
      'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit 'i 0 mT 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
        mesh.read 'log'

      "Note that an inconsistent 26-value 'log' should be accepted without complaint!"
      'i 0 mT 1 2 3 4 5 6 7 8 9 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
      (mesh) ->
        mesh.edit 'i 0 mT 1 2 3 4 5 6 7 8 9 0 1 0 0 0 0 1 r 0 0 0 s 1 1 1 t 0 0 0 bP 0 bC 1'
        mesh.read 'log'

      "Pass a 9-value 'log' string to the `set` argument"
      'i 0 mT -0.6581568121910095 -1.7472580671310425 5.7020978927612305 0 0.4779578745365143 -4.773890972137451 -1.4076658487319946 0 3.957432985305786 0.23985300958156586 0.5302779078483582 0 3 2 1 1 r 9 8 7 s 6 5 4 t 3 2 1 bP 0 bC 1'
      (mesh) ->
        mesh.edit 'r 9 8 7 s 6 5 4 t 3 2 1'
        mesh.read 'log'




      "Pass an object to the `delta` argument"


      "Pass a 'unity' 9-value object to the `delta` argument"
      'i 0 mT -0.6581568121910095 -1.7472580671310425 5.7020978927612305 0 0.4779578745365143 -4.773890972137451 -1.4076658487319946 0 3.957432985305786 0.23985300958156586 0.5302779078483582 0 3 2 1 1 r 9 8 7 s 6 5 4 t 3 2 1 bP 0 bC 1'
      (mesh) ->
        mesh.edit null, { rX:0, rY:0, rZ:0, sX:1, sY:1, sZ:1, tX:0, tY:0, tZ:0 }
        mesh.read 'log'

      "Pass a transforming 9-value object to the `delta` argument"
      'i 0 mT 25.574983596801758 22.437387466430664 -33.85976791381836 0 -29.616554260253906 9.995354652404785 -15.746511459350586 0 -0.2124314159154892 20.078948974609375 13.144987106323242 0 21 22 23 1 r 21 22 23 s 48 35 24 t 21 22 23 bP 0 bC 1'
      (mesh) ->
        mesh.edit null, { rX:12, rY:14, rZ:16, sX:8, sY:7, sZ:6, tX:18, tY:20, tZ:22 }
        mesh.read 'log'

      "Pass a transforming 2-value object to the `delta` argument"
      'i 0 mT 25.574983596801758 -3.992623805999756 40.422508239746094 0 74.0413818359375 3.6715314388275146 -46.48271942138672 0 -0.2124314159154892 -23.895618438720703 -2.2258212566375732 0 21 22 23 1 r -479 22 23 s 48 -87.5 24 t 21 22 23 bP 0 bC 1'
      (mesh) ->
        mesh.edit null, { rX:-500, sY:-2.5 }
        mesh.read 'log'




      "Pass an 'nwang' string to the `delta` argument"


      "Pass a 'unity' 9-value 'nwang' string to the `delta` argument"
      'i 0 mT 25.574983596801758 -3.992623805999756 40.422508239746094 0 74.0413818359375 3.6715314388275146 -46.48271942138672 0 -0.2124314159154892 -23.895618438720703 -2.2258212566375732 0 21 22 23 1 r -479 22 23 s 48 -87.5 24 t 21 22 23 bP 0 bC 1'
      (mesh) ->
        mesh.edit null, '셼셼셼죨죨죨셼셼셼'
        mesh.read 'log'


      "Pass a transforming 9-value 'nwang' string to the `delta` argument"
      'i 0 mT 0 0 0 0 -18.84529685974121 -2.4989914894104004 39.695213317871094 0 0.00007556568016298115 -0.023954685777425766 -0.0014721800107508898 0 165 23 23.000999450683594 1 r -479.0315 21.988 35 s 0 44.0125 0.024 t 165 23 23.001 bP 0 bC 1'
      (mesh) ->
        mesh.edit null, '쁁섄첀셼밁솆퀜죨솆'
        mesh.read 'log'


@todo `oT` set to 'rts'  
@todo `oT` set to 'srt'  


@todo test the special 'reset' value passed to `set` - for Item.Mesh, test bP and bC in particular


    ];



