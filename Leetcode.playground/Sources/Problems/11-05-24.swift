import Foundation

// https://leetcode.com/problems/minimum-cost-to-hire-k-workers

func mincostToHireWorkers(_ quality: [Int], _ wage: [Int], _ k: Int) -> Double {
    let pairs = zip(quality, wage)
    .map { (q, w) in
        (q, Double(w) / Double(q))
    }
    .sorted { $0.1 < $1.1 }
    var res = Double(Int.max)
    var heap = Heap<Int>(>)
    var curr = 0
    for pair in pairs {
        heap.insert(pair.0)
        curr += pair.0
        if heap.count > k {
            let mx = heap.remove()!
            curr -= mx
        }
        if heap.count < k { continue }
        res = min(res, Double(curr) * pair.1)
    }
    return res
}
