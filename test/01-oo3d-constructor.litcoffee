01 Oo3d Constructor
===================


    tudor.add [
      "01 Oo3d Constructor"
      tudor.is




      "The class and instance are expected types"


      "The class is a function"
      ªF
      -> Main


      "`new` returns an object"
      ªO
      -> new Main




      "Config exceptions"
      tudor.throw


      "If set, `config` must be an object"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        Optional `config` is array not object"""
      -> new Main []


      "If set, `config.$main` must be an HTMLCanvasElement"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        Optional `config.$main` is number not HTMLCanvasElement"""
      -> new Main { $main:123 }


      "If set, `config.bkgnd` must be a Float32Array"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        Optional `config.bkgnd` is number not float32array"""
      -> new Main { bkgnd:456 }


      "`config.bkgnd` must contain four elements"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        If set `config.bkgnd` must contain four elements"""
      -> new Main { bkgnd: new Float32Array [1,1,1] }


      "`config.bkgnd[0]` must be 0 or greater"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[0]` (red) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [-0.02,1,1,1] }


      "`config.bkgnd[0]` must be 1 or less"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[0]` (red) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [1.02,1,1,1] }


      "`config.bkgnd[1]` must be 0 or greater"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[1]` (green) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,-0.02,1,1] }


      "`config.bkgnd[1]` must be 1 or less"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[1]` (green) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1.02,1,1] }


      "`config.bkgnd[2]` must be 0 or greater"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[2]` (blue) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,-Infinity,1] }


      "`config.bkgnd[2]` must be 1 or less"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[2]` (blue) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,Infinity,1] }


      "`config.bkgnd[3]` must be 0 or greater"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[3]` (alpha) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,1,-0.000001] }


      "`config.bkgnd[3]` must be 1 or less"
      """
      /src/class-main.litcoffee:Oo3d:constructor()
        `config.bkgnd[3]` (alpha) is not within range 0-1"""
      -> new Main { bkgnd: new Float32Array [0,1,0,1.00001] }




      "Config usage"
      tudor.equal


      "`config.bkgnd` can contain four floats 0-1, or NaN"
      '[object Oo3d]'
      -> ''+(new Main { bkgnd: new Float32Array [1,0,NaN,0.5] })



    ]
