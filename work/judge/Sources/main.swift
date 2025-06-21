import AcFoundation

let (_, M): (Int, Int) = stdin()
var m: [Pack<Int, Int>: Int] = [:]
var ans = 0
for _ in 0 ..< M {
  var (u,v): (Int, Int) = stdin()
  if u == v {
    ans += 1
    continue
  }
  if u > v {
    swap(&u, &v)
  }
  m[.init(u, v), default: 0] += 1
}
m.forEach {
  ans += $0.value - 1
}
print(ans)

print(gcd(12, 16))
