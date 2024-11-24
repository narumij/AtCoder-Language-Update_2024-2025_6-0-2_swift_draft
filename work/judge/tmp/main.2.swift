import Foundation
import AcFoundation

private let main: () = {
  do { try Answer() } catch { /* WA */  }
}()

// ちょっと急ぎで試す必要があり、窃盗ACをしています。すみません。
// 元はこちら　https://atcoder.jp/contests/abc235/submissions/34773466

@inlinable
public func Answer() throws {
  func keta(_ n:Int) -> Int {
      var kt=0,_n=n
      while _n > 0 {_n/=10;kt+=1    }
      return kt
  }
  func dod(_ c:Int) -> Int {
      var ket = keta(c)-1
      var last=c%10
      while ket>0 {last*=10;ket-=1    }
      return last + c/10
  }
  let(a,n)=(Int.stdin, Int.stdin)
  let nketa=keta(n)
  var z=Set<Int>()
  var queue = ArraySlice<((Int,Int))>()
  var ans = -1
  queue.append((1,0))
  while let (c,p)=queue.popFirst() {
      if !z.contains(a*c) {
          if a*c == n {ans=p+1;break}
          if keta(a*c)<=nketa {z.insert(a*c);queue.append((a*c,p+1))}
      }
      if c>10 && c%10 != 0 {
          let d=dod(c)
          if !z.contains(d) {
              if d==n {ans=p+1;break}
              z.insert(d)
              queue.append((d,p+1))
          }
      }
  }
  print(ans)
}
