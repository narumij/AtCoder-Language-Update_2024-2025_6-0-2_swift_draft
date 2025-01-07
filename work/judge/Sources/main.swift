import AcFoundation
import Foundation
import SortedCollections
import Algorithms
import AcMemoize
import RedBlackTreeModule
import PermutationModule

private let main: () = {
  do { try Answer() } catch { /* WA */  }
}()

@MainActor
@inlinable
public func Answer() throws {
  try MainActor.assumeIsolated {
    let i: Int = .stdin
//    let s: SortedSet<Int> = .init()
    print("Hello, MainActor!")
    print("Is Main Thread: \(Thread.isMainThread)")
    try Some()
    hoge()
  }
}

@MainActor
@inlinable
public func Some() throws {
  print("Hello, MainActor Again!")
  print("Is Main Thread: \(Thread.isMainThread)")
}

@MainActor
@inlinable
public func Some2() throws {
  var a = [1,2,3,4]
  for p in a.permutations() {
    
  }
}

@usableFromInline func hoge() {
  
  @Memoize
  func fibonacci(_ n: Int) -> Int {
      if n <= 1 { return n }
      return fibonacci(n - 1) + fibonacci(n - 2)
  }

  print(fibonacci(40)) // Output: 102_334_155
}
