import Foundation

let N = Int(readLine()!)!

var d = repeatElement(0, count: N) + []

var A = readLine()!.split(separator: " ").compactMap { Int($0) }.map { $0 - 1 }

for (i,a) in A.enumerated() {
  d[a] = i
}

var ans: [(Int,Int)] = []
for i in 0 ..< N {
  if A[i] != i {
    let p = d[i]
    ans.append((i,p))
    d.swapAt(A[i], A[p])
    A.swapAt(i, p)
  }
}

print(ans.count)
ans.forEach {
  print($0.0 + 1, $0.1 + 1)
}
