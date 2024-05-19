
func evaluateTree(_ root: TreeNode?) -> Bool {
    guard let node = root else { return false }
    let val = node.val
    if val == 0 || val == 1 {
        return val == 0 ? false : true
    }
    let leftVal = evaluateTree(node.left)
    let rightVal = evaluateTree(node.right)

    return val == 2 ? leftVal || rightVal : leftVal && rightVal
}

