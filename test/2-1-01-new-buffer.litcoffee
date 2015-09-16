2-1-01 `new Buffer`
===================


    tudor.add [
      "2-1-01 `new Buffer`"
      tudor.is




      "(Mock an Oo3d instance)"
      mockOo3d




      "The class and instance are expected types"


      "The class is a function"
      ªF
      -> Buffer

      "`new` returns an object"
      ªO
      (oo3d) -> new Buffer oo3d, 0 # `main`, `index`

      tudor.equal

      "`buffer.toString()` as expected"
      '[object Buffer]'
      (oo3d) ->
        buffer = new Buffer oo3d, 0
        ''+buffer

      "`buffer.C` as expected"
      'Buffer'
      (oo3d) ->
        buffer = new Buffer oo3d, 0
        buffer.C




      "Buffer Constructor exceptions"
      tudor.throw


      "`config.main` must be an object"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#NaN()
        `main` is number not object"""
      (oo3d) -> new Buffer 123

      "`config.main` must be an Oo3d instance"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#NaN()
        `main` is '[object Object]' not '[object Oo3d]'"""
      (oo3d) -> new Buffer {}

      "`index` must be a number"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#1()
        `index` is boolean not number"""
      (oo3d) -> new Buffer oo3d, true

      "`index` must be an integer"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#3.5()
        `index` is 3.5 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Buffer oo3d, 3.5

      "`index` must be positive"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#-44()
        `index` is -44 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Buffer oo3d, -44

      "`index` must be below 2^53"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#9007199254740992()
        `index` is 9007199254740992 not 0 or a positive integer below 2^53"""
      (oo3d) -> new Buffer oo3d, 9007199254740992

      "`config` must be an object"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#0()
        Optional `config` is date not object"""
      (oo3d) -> new Buffer oo3d, 0, new Date

      "If set, `config.data` must be a regular array"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#0()
        `config.data` is float32array not array"""
      (oo3d) -> new Buffer oo3d, 0, { data:new Float32Array() }

      "If set, `config.data` must only contain numbers"
      """
      /oo3d/src/buffer/base-buffer.litcoffee Buffer#0()
        `config.data` contains a non-numeric value"""
      (oo3d) -> new Buffer oo3d, 0, { data:[1, 2, 'foo'] }




      "Buffer Constructor usage"
      tudor.is


      "`config` can contain unexpected properties, which are not recorded"
      ªU
      (oo3d) ->
        buffer = new Buffer oo3d, 0, { foo:'bar' }
        buffer.foo

      "If set, `config.data` can contain strings which resolve to numbers"
      ªO
      (oo3d) ->
        buffer = new Buffer oo3d, 0, { data:[1, 2, '3'] }
        buffer.glData



    ]












