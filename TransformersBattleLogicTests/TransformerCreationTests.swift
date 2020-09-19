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
            it("should have all specs set to 0") {
               expect(sut.transformer.strength).to(be(0))
               expect(sut.transformer.intelligence).to(be(0))
               expect(sut.transformer.speed).to(be(0))
               expect(sut.transformer.endurance).to(be(0))
               expect(sut.transformer.rank).to(be(0))
               expect(sut.transformer.courage).to(be(0))
               expect(sut.transformer.firepower).to(be(0))
               expect(sut.transformer.skill).to(be(0))
            }
         }
      }
   }
}
