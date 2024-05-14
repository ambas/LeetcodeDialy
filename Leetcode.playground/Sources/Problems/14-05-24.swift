/// Problem Link: https://leetcode.com/problems/path-with-maximum-gold/

/// Solution
class Solution {
    func getMaximumGold(_ grid: [[Int]]) -> Int {
        let (rowCount, colCount) = (grid.count, grid[0].count)
        var visited = Set<[Int]>()
        
        func makeDirection(_ point: [Int]) -> [[Int]] {
            let (row, col) = (point[0], point[1])
            let directions = [[0, 1], [1, 0], [-1, 0], [0, -1]]
            var res = [[Int]]()
            for direction in directions {
                let newRow = row + direction[0]
                let newCol = col + direction[1]
                // check out of bound
                if newRow >= 0 && newRow < rowCount && newCol >= 0 && newCol < colCount {
                    let newPoint = [newRow, newCol]
                    // check its valid path
                    if !visited.contains(newPoint) && grid[newRow][newCol] > 0 {
                        res.append(newPoint)
                    }
                }
            }
            return res
        }
        var res = 0
        func backtrack(_ point: [Int], _ curr: Int) {
            defer {
                visited.remove(point)
            }
            visited.insert(point)
            let (row, col) = (point[0], point[1])
            let curr = curr + grid[row][col]
            let directions = makeDirection(point)
            
            if directions.isEmpty { res = max(res, curr); return }
            for direction in directions {
                backtrack(direction, curr)
            }
        }
        for row in 0..<rowCount {
            for col in 0..<colCount {
                backtrack([row, col], 0)
            }
        }
        
        return res
    }
}

/// Test Cases
