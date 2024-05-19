import Collections
// Link: https://leetcode.com/problems/longest-happy-string/

struct Day05_99: ChallengeDay {
    // Replace this with your solution for the first part of the day's challenge.
    func solution() -> [String] {
        func longestDiverseString(_ a: Int, _ b: Int, _ c: Int) -> String {
            //            var heap = Heap<Int>()
            return ""
        }
        let case1 = longestDiverseString(1, 1, 7)
        let case2 = longestDiverseString(1, 1, 1)
        let case3 = longestDiverseString(7, 1, 0)
        return [case1, case2, case3]
    }
    
}

class Solution {
    func longestDiverseString(_ a: Int, _ b: Int, _ c: Int) -> String {
            var res = ""
            let arr = [("a", a), ("b", b), ("c", c)].filter { $0.1 > 0 }
            var heap = Heap(arr) {
                $0.1 > $1.1
            }
            while let (char, count) = heap.remove() {
                defer {
                    if count > 1 {
                        heap.insert((char, count - 1))
                    }
                }
                if res.count < 2 {
                    res.append(char)
                    continue
                }
                if String(res.suffix(2)) == "\(char)\(char)" {
                    if heap.isEmpty { break }
                    let (newChar, newCount) = heap.remove()!
                    res.append(newChar)
                    if newCount > 1 {
                        heap.insert((newChar, newCount - 1))
                    }
                }
                res.append(char)
            }
            return res
        }
}
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

