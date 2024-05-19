import XCTest

@testable import LeetCodeDialyChallenge

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day05_19Tests: XCTestCase {

  func testSolution() throws {
    let challenge = Day05_19()
    XCTAssertEqual(challenge.solution(), [6,9,42])
  }

}
