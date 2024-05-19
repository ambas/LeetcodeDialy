@_exported import Algorithms
@_exported import Collections
import Foundation

protocol ChallengeDay {
    associatedtype ResultType
    
  /// The day of the Advent of Code challenge.
  ///
  /// You can implement this property, or, if your type is named with the
  /// day number as its suffix (like `Day01`), it is derived automatically.
  static var day: String { get }

  /// Computes and returns the answer for part one.
  func solution() async throws -> ResultType

}

extension ChallengeDay {
  // Find the challenge day from the type name.
  static var day: String {
    let typeName = String(reflecting: Self.self)
    guard let i = Array(typeName).firstIndex(where: { $0.isNumber })
    else {
      fatalError(
        """
        Day number not found in type name: \
        implement the static `day` property \
        or use the day number as your type's suffix (like `Day3`).")
        """)
    }
    return String(Array(typeName)[i...])
  }

  var day: String {
    Self.day
  }


}
