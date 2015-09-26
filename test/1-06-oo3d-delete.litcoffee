1-06 `oo3d.delete()`
====================


    tudor.add [
      "1-06 `oo3d.delete()`"
      tudor.equal




      "(Mock an Oo3d instance)"
      mockOo3d




      "(Add various instances which these tests will try to delete)"
      (oo3d, item, itemI) ->
        itemLut =
          itemMeshI:          itemI
          itemMeshTwoI:       oo3d.add 'Item.Mesh'
          itemCameraI:        oo3d.add 'Item.Camera'
          itemLayerI:         oo3d.add 'Layer.Simple'
          programFlatI:       oo3d.add 'Program.Flat'
          programFlatItemI:   oo3d.add 'Program.FlatItem'
          programFlatwhiteI:  oo3d.add 'Program.Flatwhite'

        itemLut.rendererWireframeI = oo3d.add('Renderer.Wireframe', {
          programI: itemLut.programFlatwhiteI
          cameraI:  itemLut.itemCameraI
          meshIs:   [itemLut.itemMeshI, itemLut.itemMeshTwoI]
        })

        [oo3d, itemLut]




      "State is as expected before any deletion"


      "`oo3d._all` contains 12 instances"
      12
      (oo3d) -> l = 0; (l++ if inst) for inst in oo3d._all; l


      "`oo3d.layers` contains 1 instance"
      1
      (oo3d) -> l = 0; (l++ if inst) for inst in oo3d.layers; l




      "Various type-checks"
      tudor.is


      "`oo3d.delete()` is a function"
      ªF
      (oo3d) -> oo3d.delete

      "`oo3d.deleteOne()` (the private function) is not available in the public API"
      ªU
      (oo3d) -> oo3d.deleteOne

      "Before deleting programFlatI, `oo3d._all[itemLut.programFlatI]` is an object"
      ªO
      (oo3d, itemLut) -> oo3d._all[itemLut.programFlatI]

      "`oo3d.delete(itemLut.programFlatI)` returns an object"
      ªO
      (oo3d, itemLut) -> oo3d.delete itemLut.programFlatI

      "After deleting programFlatI, `oo3d._all[itemLut.programFlatI]` is undefined"
      ªU
      (oo3d, itemLut) -> oo3d._all[itemLut.programFlatI]




      "Checks after basic programFlatI deletion"
      tudor.equal


      "`oo3d.deleteOne()` (the private function) is not reachable by Tudor"
      ªU
      (oo3d) -> typeof deleteOne

      "After deleting programFlatI, `oo3d._all` now contains 11 instances"
      11
      (oo3d) -> l = 0; (l++ if inst) for inst in oo3d._all; l

      "After deleting programFlatI, `oo3d.layers` still contains 1 instance"
      1
      (oo3d) -> l = 0; (l++ if inst) for inst in oo3d.layers; l




      "Delete a Item.Mesh instances"


      "Before deleting itemMeshTwoI, `oo3d._all[itemLut.itemMeshI]` is '[object Item.Mesh]'"
      '[object Item.Mesh]'
      (oo3d, itemLut) -> ''+oo3d._all[itemLut.itemMeshI]

      "Before deleting itemMeshTwoI, rendererWireframeI has two elements in `meshes`"
      '4 5'
      (oo3d, itemLut) -> (mesh.index for mesh in oo3d._all[itemLut.rendererWireframeI].meshes).join ' '

      "`oo3d.delete(itemLut.itemMeshTwoI)` returns an object"
      '[object Oo3d]'
      (oo3d, itemLut) -> ''+(oo3d.delete itemLut.itemMeshTwoI)

      "After deleting itemMeshTwoI, rendererWireframeI has one element in `meshes`"
      '4'
      (oo3d, itemLut) -> (mesh.index for mesh in oo3d._all[itemLut.rendererWireframeI].meshes).join ' '

      tudor.throw

      "A second call to `oo3d.delete(itemLut.itemMeshTwoI)` throws an error"
      """
      /oo3d/src/class-main.litcoffee Main:delete()
        `_all[5]` does not exist"""
      (oo3d, itemLut) -> ''+(oo3d.delete itemLut.itemMeshTwoI)

      tudor.equal

      "After trying to delete itemMeshTwoI for a second time, rendererWireframeI still has one element in `meshes`"
      '4'
      (oo3d, itemLut) -> (mesh.index for mesh in oo3d._all[itemLut.rendererWireframeI].meshes).join ' '

      "After deleting itemMeshI, rendererWireframeI has no elements in `meshes`"
      ''
      (oo3d, itemLut) ->
        oo3d.delete itemLut.itemMeshI
        (mesh.index for mesh in oo3d._all[itemLut.rendererWireframeI].meshes).join ' '

      "After deleting itemMeshI and itemMeshTwoI, `oo3d._all` now contains 9 instances"
      9
      (oo3d) -> l = 0; (l++ if inst) for inst in oo3d._all; l

      "After deleting itemMeshI and itemMeshTwoI, `oo3d.layers` still contains 1 instance"
      1
      (oo3d) -> l = 0; (l++ if inst) for inst in oo3d.layers; l


@todo more delete tests

    ];







