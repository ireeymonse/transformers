//
//  WarTests.swift
//  TransformersBattleLogicTests
//
//  Created by Iree García on 19/09/20.
//

import Nimble
import Quick

class WarTests: QuickSpec {
   override func spec() {
      var sut: WarViewModel!

      describe("A war ???") {
         context("with 3 warriors") {
            beforeEach {
               let warriors: [Transformer] = [
                  "Hubcap, A, 4,4,4,4,4,4,4,4",
                  "Soundwave, D, 8,9,2,6,7,5,6,10",
                  "Bluestreak, A, 6,6,7,9,5,2,9,7",
               ]
               sut = WarViewModel(between: warriors)
            }
            it("should match them by rank") {
               // TODO:
            }
         }
      }
   }
}
