//
//  TransformerCreationTests.swift
//  TransformersBattleTests
//
//  Created by Iree García on 19/09/20.
//

import Nimble
import Quick

class TransformerCreationTests: QuickSpec {
   override func spec() {
      var sut: TransformerViewModel!

      beforeEach {
         sut = TransformerViewModel()
      }

      describe("A new transformer") {
         context("with no changes made") {
            it("should be an Autobot™") {
               expect(sut.team).to(equal(.autobot))
            }
            it("should have no name") {
               expect(sut.name).to(beEmpty())
            }
            it("should have a team name") {
               expect(sut.teamName).toNot(beEmpty())
            }
            it("should have a value for each spec") {
               expect(sut.specsList.count).to(equal(TransformerSpec.allCases.count))
            }
            it("should have all specs set to 5") {
               expect(sut.specsList).to(allPass { $0?.value == 5 })
            }
            it("should not be valid") {
               expect(sut.isValid).to(beFalse())
            }
         }

         context("edited correctly") {
            beforeEach {
               sut.name = "Testatron"
               sut.team = .decepticon
               TransformerSpec.allCases.forEach { sut[$0] = 10 }
            }
            it("should be valid") {
               expect(sut.isValid).to(beTrue())
            }
         }

         context("given incorrect values") {
            beforeEach {
               // initial correct state
               sut.name = "Optimus Test"
               sut.team = .autobot
               TransformerSpec.allCases.forEach { sut[$0] = 10 }
            }
            it("should validate name") {
               sut.name = "               "
               expect(sut.isValid).to(beFalse())
            }
            it("should validate a spec too low") {
               sut[.intelligence] = 0
               expect(sut.isValid).to(beFalse())
            }
            it("should validate a spec too high") {
               sut[.skill] = 11
               expect(sut.isValid).to(beFalse())
            }
         }
      }
   }
}
