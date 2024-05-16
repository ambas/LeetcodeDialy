class Solution {
    
    
    func maximumSafenessFactor(_ grid: [[Int]]) -> Int {
        let (rowCount, colCount) = (grid.count, grid.count)
        func makeDirection(_ point: [Int], _ allDirection: Bool) -> [[Int]] {
            let (row, col) = (point[0], point[1])
            let directions = allDirection ? [[0, 1], [1, 0], [0, -1], [-1, 0]] : [[0, 1], [1, 0]]
            var res = [[Int]]()
            for direction in directions {
                let newRow = row + direction[0]
                let newCol = col + direction[1]
                if newRow >= 0 && newRow < rowCount && newCol >= 0 && newCol < colCount {
                    res.append([newRow, newCol])
                }
            }
            return res
        }
        func makeDistanceGrid() -> [[Int]] {
            var distanceGrid = grid
            var grid = distanceGrid
            var queue = [[Int]]()
            // find 1, and change distance value to initial
            for row in 0..<rowCount {
                for col in 0..<colCount {
                    if grid[row][col] == 1 {
                        grid[row][col] = 0
                        queue.append([row, col])
                    } else {
                        grid[row][col] = -1
                    }
                }
            }
            var set = Set<[Int]>()
            // do multi source BFS
            var newQueue = [[Int]]()
            var distance = 0
            while let node = queue.first {
                queue.removeFirst()
                let (row, col) = (node[0],node[1])
                let val = grid[row][col]
                if set.contains(node) {
                    if queue.isEmpty {
                        queue = newQueue
                        distance += 1
                        newQueue = []
                    }
                    continue
                }
                set.insert(node)
                if val == -1 {
                    grid[row][col] = distance
                } else {
                    grid[row][col] = min(val, distance)
                }
                newQueue.append(contentsOf: makeDirection(node, true))
                if queue.isEmpty {
                    queue = newQueue
                    distance += 1
                    newQueue = []
                }
            }
            return grid
            
        }
        let grid = makeDistanceGrid()
        var heap = Heap<[Int]> { $0[0] > $1[0] }
        var distance = grid[0][0]
        heap.insert([distance, 0, 0])
        var visited = Set<[Int]>()
        while let node = heap.remove() {
            let (val, row, col) = (node[0], node[1], node[2])
            if row == rowCount - 1 && col == colCount - 1 {
                break
            }
            let point = [row, col]
            if !visited.contains(point) { continue }
            for nei in makeDirection(point, false) {
                heap.insert([min(distance, val), nei[0], nei[1]])
            }
            distance = min(distance, val)
        }

        
        
        return distance
    }
}

print("sample")

/*
 [[0,1,1],
 [0,1,1],
 [0,0,0]]
 */
