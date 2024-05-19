import Algorithms

struct Day05_19: ChallengeDay {
    // Replace this with your solution for the first part of the day's challenge.
    func solution() -> [Int] {
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
        let case1 = maximumValueSum([1,2,1], 3, [[0,1],[0,2]])
        let case2 = maximumValueSum([2,3], 7, [[0,1]])
        let case3 = maximumValueSum([7,7,7,7,7,7], 3, [[0,1],[0,2],[0,3],[0,4],[0,5]])
        return [case1, case2, case3]
    }
    
}
