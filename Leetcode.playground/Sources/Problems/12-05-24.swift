import Foundation

// https://leetcode.com/problems/largest-local-values-in-a-matrix/

func largestLocal(_ grid: [[Int]]) -> [[Int]] {
    let (rowCount, colCount) = (grid.count, grid[0].count)
    var res = Array(
        repeating: Array(repeating: 0, count: colCount - 2),
        count: rowCount - 2
    )

    func scan(_ point: [Int]) -> Int {
        let (startRow, startCol) = (point[0] - 1, point[1] - 1)
        var res = 0
        for row in startRow..<(startRow + 3) {
            for col in startCol..<(startCol + 3) {
                res = max(res, grid[row][col])
            }
        }
        return res
    }

    for row in 0..<res.count {
        for col in 0..<res[0].count {
            res[row][col] = scan([row + 1, col + 1])
        }
    }

    return res
}
