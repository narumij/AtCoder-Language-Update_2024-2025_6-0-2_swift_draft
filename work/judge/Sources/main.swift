import AcFoundation

#if true
import AcFoundation
import AcCollections

var (N, m): (Int,Int) = stdin()
var p_rev = (0..<N) + []
var p = (0..<N).map { [$0] }
var e = (0..<N).map { _ in RedBlackTreeSet<Int>() }
var u: [Int] = []
var v: [Int] = []
for _ in 0..<m {
  let (_u,_v) = (Int.stdin - 1, Int.stdin - 1)
  u.append(_u)
  v.append(_v)
  e[_u].insert(_v)
  e[_v].insert(_u)
}
let Q = Int.stdin
for _ in 0..<Q {
  let x = Int.stdin
  var vx = p_rev[u[x - 1]]
  var vy = p_rev[v[x - 1]]
  if vx != vy {
    let valx = (e[vx].count) + (p[vx].count)
    let valy = (e[vy].count) + (p[vy].count)
    if valx > valy { swap(&vx, &vy) }
    let sz = p[vx].count
    for j in 0..<sz {
      p[vy].append(p[vx][j])
      p_rev[p[vx][j]] = vy
    }
    p[vx].removeAll()
    for vz in e[vx] {
      if vz == vy {
        m -= 1
        e[vy].remove(vx)
      } else {
        if e[vy].contains(vz) {
          m -= 1
        } else {
          e[vy].insert(vz)
          e[vz].insert(vy)
        }
        e[vz].remove(vx)
      }
    }
    e[vx].removeAll()
  }
  print(m)
}
#else

#if ONLINE_JUDGE
print("ONLINE_JUDGE")
#endif

import Convinience
import BigInt

print(factorial(10 as BigInt))

#endif


