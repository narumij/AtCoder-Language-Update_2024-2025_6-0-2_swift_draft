import AcFoundation
import Foundation

private let main: () = {
    // 5.8.1では、nonisoletedなmain関数からMainActorを呼び出せなかったが、
    // 6.0.3では呼び出せるようになっている
     do { try Answer() } catch { /* WA */  }
}()

@MainActor
@inlinable
public func Answer() throws {
  try MainActor.assumeIsolated {
    print("Hello, MainActor!")
    print("Is Main Thread: \(Thread.isMainThread)")
    try Some()
  }
}

@MainActor
@inlinable
public func Some() throws {
  print("Hello, MainActor Again!")
  print("Is Main Thread: \(Thread.isMainThread)")
}
