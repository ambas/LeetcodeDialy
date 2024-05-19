    func maximumSafenessFactor(_ grid: [[Int]]) -> Int {
        let (rowCount, colCount) = (grid.count, grid[0].count)
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
            // var distanceGrid = grid
            var grid = grid
            var queue = [[Int]]()
            // find 1, and change distance value to initial
            var set = Set<[Int]>()
            var dp = [[Int]: Int]()
            for row in 0..<rowCount {
                for col in 0..<colCount where grid[row][col] == 1  {
                    queue.append([row, col])
                    set.insert([row, col])
                    dp[[row, col]] = 0
                }
            }
            
            // do multi source BFS
            var newQueue = [[Int]]()
            while let node = queue.first {
                queue.removeFirst()
                let (row, col) = (node[0],node[1])
                let val = dp[[row, col]]!
                 grid[row][col] = val
                 for nei in  makeDirection(node, true) where !set.contains(nei) {
                    dp[[nei[0], nei[1]]] = val + 1
                    set.insert(nei)
                    queue.append(nei)
                 }
            
            }
            return grid
            
        }
        // func makeDistanceGrid2() -> [[Int]] {}
        let grid = makeDistanceGrid()
        var heap = Heap<[Int]> { $0[0] > $1[0] }
        heap.insert([grid[0][0], 0, 0])
        var visited = Set<[Int]>()
        visited.insert([0,0])
        while let node = heap.remove() {
            let (distance, row, col) = (node[0], node[1], node[2])
            if row == rowCount - 1 && col == colCount - 1 {
                return distance
            }
            let point = [row, col]
            
            for nei in makeDirection(point, true) where !visited.contains(nei) {
                visited.insert(nei)
                let newVal = min(grid[nei[0]][nei[1]], distance)
                heap.insert([newVal, nei[0], nei[1]])
            }
        }

        
        
        return 0
    }
/*
[[0,1,1],
[0,1,1],
[0,0,1]]

[[1, 0, 0],
[1, 0, 0],
[2, 1, 0]]
 */

import Foundation

public struct Heap<T> {

  var nodes = [T]()

  private var orderCriteria: (T, T) -> Bool

  public init(_ sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
  }

  public init(_ array: [T], _ sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
    configureHeap(from: array)
  }

  private mutating func configureHeap(from array: [T]) {
    nodes = array
    for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
      shiftDown(i)
    }
  }

  public var isEmpty: Bool {
    return nodes.isEmpty
  }

  public var count: Int {
    return nodes.count
  }

  @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
    return (i - 1) / 2
  }

  @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 1
  }

  @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 2
  }

  public func peek() -> T? {
    return nodes.first
  }

  public mutating func insert(_ value: T) {
    nodes.append(value)
    shiftUp(nodes.count - 1)
  }

  public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
    for value in sequence {
      insert(value)
    }
  }

  public mutating func replace(index i: Int, value: T) {
    guard i < nodes.count else { return }

    remove(at: i)
    insert(value)
  }

  @discardableResult public mutating func remove() -> T? {
    guard !nodes.isEmpty else { return nil }

    if nodes.count == 1 {
      return nodes.removeLast()
    } else {
      let value = nodes[0]
      nodes[0] = nodes.removeLast()
      shiftDown(0)
      return value
    }
  }

  @discardableResult public mutating func remove(at index: Int) -> T? {
    guard index < nodes.count else { return nil }

    let size = nodes.count - 1
    if index != size {
      nodes.swapAt(index, size)
      shiftDown(from: index, until: size)
      shiftUp(index)
    }
    return nodes.removeLast()
  }

  internal mutating func shiftUp(_ index: Int) {
    var childIndex = index
    let child = nodes[childIndex]
    var parentIndex = self.parentIndex(ofIndex: childIndex)

    while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
      nodes[childIndex] = nodes[parentIndex]
      childIndex = parentIndex
      parentIndex = self.parentIndex(ofIndex: childIndex)
    }

    nodes[childIndex] = child
  }

  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
    let rightChildIndex = leftChildIndex + 1

    var first = index
    if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
      first = leftChildIndex
    }
    if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
      first = rightChildIndex
    }
    if first == index { return }

    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
  }

  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: nodes.count)
  }

}
