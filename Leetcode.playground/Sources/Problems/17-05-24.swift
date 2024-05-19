private class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func removeLeafNodes(_ root: TreeNode?, _ target: Int) -> TreeNode? {
    guard let node = root else { return nil }
    node.left = removeLeafNodes(node.left, target)
    node.right = removeLeafNodes(node.right, target)
    if node.left == nil && node.right == nil && node.val == target {
        return nil
    }
    return node
    
}
