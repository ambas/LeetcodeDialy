
/// Problem Link: https://leetcode.com/problems/score-after-flipping-matrix
/// Solution
func matrixScore(_ grid: [[Int]]) -> Int {
    var grid = grid
    let (rowCount, colCount) = (grid.count, grid[0].count)
    for row in 0..<rowCount {
        var normalVal = ""
        for col in 0..<colCount {
            normalVal += String(grid[row][col])
        }
        let flipped = String(normalVal.map { $0 == "1" ? "0" : "1" })
        if Int(normalVal, radix: 2)! < Int(flipped, radix: 2)! {
            for col in 0..<colCount {
                let val = grid[row][col]
                if val == 0 {
                    grid[row][col] = 1
                } else {
                    grid[row][col] = 0
                }
            }
        }
    }
    for col in 0..<colCount {
        var oneCount = 0
        var zeroCount = 0
        for row in 0..<rowCount {
            let val = grid[row][col]
            if val == 1 {
                oneCount += 1
            } else {
                zeroCount += 1
            }
        }
        if oneCount < zeroCount {
            for row in 0..<rowCount {
                let val = grid[row][col]
                if val == 1 {
                    grid[row][col] = 0
                } else {
                    grid[row][col] = 1
                }
            }
        }
    }
    var res = 0
    for row in 0..<rowCount {
        var normalVal = ""
        for col in 0..<colCount {
            normalVal += String(grid[row][col])
        }
        res += Int(normalVal, radix: 2)!
    }
    return res
    
}

/// Test Cases
