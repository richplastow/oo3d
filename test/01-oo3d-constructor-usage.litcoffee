01 Oo3d Constructor Usage
=========================


    tudor.add [
      "01 Oo3d Constructor Usage"
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


      "`config.$main` must not be a number"
      "If set, config.$main must be HTMLCanvasElement not number"
      -> new Main { $main:123 }

    ]
