import Foundation

func maximumValueSum(_ nums: [Int], _ k: Int, _ edges: [[Int]]) -> Int {
    let delta = nums.map {
        $0^k - $0
    }
        .sorted(by: >)
    var res = nums.reduce(0, +)
    for i in stride(from: 1, to: delta.count, by: 2) where delta[i] + delta[i - 1] > 0 {
        res += (delta[i - 1] + delta[i])
    }
    return res
}
