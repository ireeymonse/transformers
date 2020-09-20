//
//  BattleTests.swift
//  TransformersBattleLogicTests
//
//  Created by Iree García on 20/09/20.
//

import Nimble
import Quick

class BattleTests: QuickSpec {
   override func spec() {
      var sut: BattleOutcome!

      describe("A battle between regular opponents") {
         context("one superior that the other") {
            beforeEach {
               sut = BattleOutcome(
                  between: "SUPERIOR, A, 2,1,1,1,1,1,1,1",
                  and: "INFERIOR, D, 1,1,1,1,1,1,1,1"
               )
            }

            it("should be a victory") {
               guard case .victory = sut else {
                  return fail("expected .victory, got \(sut!)")
               }
            }
            it("should find the winner") {
               expect(sut.victor?.name) == "SUPERIOR"
            }
            it("should eliminate the inferior one") {
               expect(sut.eliminated.count) == 1
               expect(sut.eliminated.first?.name) == "INFERIOR"
            }
         }
         context("one smarter overall") {
            beforeEach {
               sut = BattleOutcome(
                  between: "SMART, A, 1, 2 ,1,1,1,1,1,1",
                  and: "DUMB, D, 1,1,1,1,1,1,1,1"
               )
            }
            it("should find the winner") {
               expect(sut.victor?.name) == "SMART"
            }
         }
         context("one faster overall") {
            beforeEach {
               sut = BattleOutcome(
                  between: "FAST, A, 1,1, 2 ,1,1,1,1,1",
                  and: "SLOW, D, 1,1,1,1,1,1,1,1"
               )
            }
            it("should find the winner") {
               expect(sut.victor?.name) == "FAST"
            }
         }
         context("one tougher overall") {
            beforeEach {
               sut = BattleOutcome(
                  between: "TOUGH, A, 1,1,1, 2 ,1,1,1,1",
                  and: "FLIMSY, D, 1,1,1,1,1,1,1,1"
               )
            }
            it("should find the winner") {
               expect(sut.victor?.name) == "TOUGH"
            }
         }
         context("one more ballistic overall") {
            beforeEach {
               sut = BattleOutcome(
                  between: "DIM, A, 1,1,1,1,1,1,1,1",
                  and: "BALLISTIC, D, 1,1,1,1,1,1, 2 ,1"
               )
            }
            it("should find the winner") {
               expect(sut.victor?.name) == "BALLISTIC"
            }
         }

         context("one 4pts braver and 3pts stronger") {
            beforeEach {
               sut = BattleOutcome(
                  between: "HERO, A, 10,1,1,1,1,10,1,1",
                  and: "COWARD, D, 7,10,10,10,10,6,10,10"
               )
            }
            it("should be won by the hero") {
               expect(sut.victor?.name) == "HERO"
            }
            it("should eliminate the coward") {
               expect(sut.eliminated.first?.name) == "COWARD"
            }
         }

         context("one not a hero but 3pts more skilled") {
            beforeEach {
               sut = BattleOutcome(
                  between: "EXPERT, A, 1,1,1,1,1,1,1,10",
                  // 2pts stonger, 3pts braver
                  and: "INEXPERIENCED, D, 3,10,10,10,10,4,10,7"
               )
            }
            it("should be won by the expert") {
               expect(sut.victor?.name) == "EXPERT"
            }
         }
      }

      describe("A battle with a Supreme Warrior") {
         context("against a regular oponent") {
            beforeEach {
               sut = BattleOutcome(
                  between: "Optimus Prime, A, 1,1,1,1,1,1,1,1",
                  and: "Megatron, D, 10,10,10,10,10,10,10,10"
               )
            }
            it("should be won by the supreme warrior") {
               expect(sut.victor?.name) == "Optimus Prime"
            }
         }

         context("against another Supreme Warrior") {
            beforeEach {
               sut = BattleOutcome(
                  between: "Optimus Prime, A, 1,1,1,1,1,1,1,1",
                  and: "Predaking, D, 10,10,10,10,10,10,10,10"
               )
            }
            it("should be a tie") {
               guard case .tie = sut else {
                  return fail("expected .tie, got \(sut!)")
               }
            }
            it("should eliminate both") {
               expect(sut.eliminated.count) == 2
               expect(sut.eliminated.first?.name) == "Optimus Prime"
               expect(sut.eliminated.last?.name) == "Predaking"
            }
         }

         context("against her clone") {
            beforeEach {
               sut = BattleOutcome(
                  between: "Predaking, A, 1,1,1,1,1,1,1,1",
                  and: "Predaking, D, 10,10,10,10,10,10,10,10"
               )
            }
            it("should be a tie") {
               guard case .tie = sut else {
                  return fail("expected .tie, got \(sut!)")
               }
            }
            it("should eliminate both") {
               expect(sut.eliminated.count) == 2
               expect(sut.eliminated.first?.name) == "Predaking"
               expect(sut.eliminated.first?.teamName) == "Autobot"
               expect(sut.eliminated.last?.name) == "Predaking"
               expect(sut.eliminated.last?.teamName) == "Decepticon"
            }
         }
      }
   }
}
