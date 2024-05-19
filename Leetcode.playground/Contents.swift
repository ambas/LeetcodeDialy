print("D")
10 ^ 2
8 ^ 2
/*
 Input: nums = [1,2,1], k = 3, edges = [[0,1],[0,2]]
 
 [1,2]  3 -> 2, 1 = +0
 [1,1]  3 -> 2, 2 = +2
 [
 [0,1], -> a - b = x1
 [0,2], -> a - b = x2
 [0,3], -> a - b = x3
 [0,4], -> x4
 [0,5]] -> x5
 */
for i in stride(from: 1, through: 4, by: 2){
        print(i)
}

