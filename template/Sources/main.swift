import AcFoundation
import Convenience
import RedBlackTreeModule

let N: Int = .stdin
let a = RedBlackTreeMultiSet<Int>([Int].stdin(rows: N))
let (n1, n2, n3) = (a.count(1), a.count(2), a.count(3))
let helper = IndexHelper3D(N + 2, N + 2, N + 2)
var dp = [0.0] * helper.count
for s in 1..<(3 * N + 1) {
    for j in (N + 1).range {
        for k in (N + 1).range {
            let i = s - 2 * j - 3 * k
            guard (0...N).contains(i) else { continue }
            let t = i + j + k
            if t > N {
                continue
            }
            dp[helper[i,j,k]] = Double(N) / Double(t)
            if i > 0 {
                dp[helper[i,j,k]] += dp[helper[i - 1,j,k]] * Double(i) / Double(t) }
            if j > 0 {
                dp[helper[i,j,k]] += dp[helper[i + 1,j - 1,k]] * Double(j) / Double(t) }
            if k > 0 {
                dp[helper[i,j,k]] += dp[helper[i,j + 1,k - 1]] * Double(k) / Double(t) }
        }
    }
}
print(dp[helper[n1,n2,n3]])

struct IndexHelper2D {
  public init(_ width: Int,_ height: Int) {
    self.width = width
    self.height = height
  }
  let width: Int
  let height: Int
  @inlinable
  var count: Int {
    return width * height
  }
  @inlinable
  subscript(x: Int, y: Int, z: Int) -> Int {
    x + y * width
  }
}

struct IndexHelper3D {
  public init(_ width: Int,_ height: Int,_ depth: Int) {
    self.width = width
    self.height = height
    self.depth = depth
  }
  let width: Int
  let height: Int
  let depth: Int
  @inlinable
  var count: Int {
    return width * height * depth
  }
  @inlinable
  subscript(x: Int, y: Int, z: Int) -> Int {
    x + y * width + z * width * height
  }
}

