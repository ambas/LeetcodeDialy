
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

func distributeCoins(_ root: TreeNode?) -> Int {
    var res = 0
    func dfs(_ root: TreeNode?) -> (size: Int, coint: Int) {
        guard let node = root else { return (0, 0) }
        let val = node.val
        let (leftSize, leftCoint) = dfs(node.left)
        let (rightSize, rightCoint) = dfs(node.right)
        let size = 1 + leftSize + rightSize
        let coint = val + leftCoint + rightCoint
        res += abs(size - coint)
        return (size, coint)
    }
    dfs(root)
    return res
}
