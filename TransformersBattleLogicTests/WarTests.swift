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

      describe("A war between 3 warriors") {
         context("with 2 on the winning side") {
            beforeEach {
               let warriors: [Transformer] = [
                  "SPARED, D, 4,4,4,4,4,4,4,4",
                  "VICTOR, D, 8,9,2,6,7,5,6,10", // higher ranked
                  "ELIMINATED, A, 6,6,7,9,5,2,9,7",
               ]
               sut = WarViewModel(between: warriors)
            }
            it("should have one battle") {
               expect(sut.battleCountText) == "1 battle"
            }
            it("should sort them by higher rank") {
               expect(sut.outcomeText).to(contain("VICTOR"))
            }
            it("should reflect the winner and its team") {
               expect(sut.outcomeText) == "Winning team (Decepticons): VICTOR"
            }
            it("should have no survivors") {
               expect(sut.survivorsText).to(beEmpty())
            }
         }

         context("with 2 on the losing side") {
            beforeEach {
               let warriors: [Transformer] = [
                  "SURVIVOR, A, 4,4,4,4,4,4,4,4", // spared
                  "VICTOR, D, 8,9,2,6,7,5,6,10",
                  "ELIMINATED, A, 6,6,7,9,5,2,9,7",
               ]
               sut = WarViewModel(between: warriors)
            }
            it("should have one survivor") {
               expect(sut.survivorsText) == "Survivors from the losing team (Autobots): SURVIVOR"
            }
         }

         context("all on the same side") {
            beforeEach {
               let warriors: [Transformer] = [
                  "LUCKY, A, 4,4,4,4,4,4,4,4",
                  "LUCKY, A, 8,9,2,6,7,5,6,10",
                  "LUCKY, A, 6,6,7,9,5,2,9,7",
               ]
               sut = WarViewModel(between: warriors)
            }
            it("should have no battles") {
               expect(sut.battleCountText).to(beEmpty())
            }
            it("should be declared a tie") {
               expect(sut.outcomeText) == "It's a Tie!"
            }
            it("should not show survivors") {
               expect(sut.survivorsText).to(beEmpty())
            }
         }
      }

      // TODO: tests multiple battles, no battles, mayhem, etc.
   }
}
