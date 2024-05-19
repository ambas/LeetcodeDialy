import XCTest

@testable import LeetCodeDialyChallenge

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day00Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000

    """

  func testSolution() throws {
    let challenge = Day00_00()
    XCTAssertEqual(String(describing: challenge.solution()), "6000")
  }

}
