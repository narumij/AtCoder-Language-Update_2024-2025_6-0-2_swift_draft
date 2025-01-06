import Foundation
import AcMemoize


private let main: () = {
  do { try Answer() } catch { /* WA */  }
}()

@usableFromInline
@Memoize
func tarai(x: Int, y: Int, z: Int) -> Int {
  if x <= y {
    return y
  } else {
    return tarai(
      x: tarai(x: x - 1, y: y, z: z),
      y: tarai(x: y - 1, y: z, z: x),
      z: tarai(x: z - 1, y: x, z: y))
  }
}

@MainActor
@inlinable
public func Answer() throws {
  print("Hello, Swift Macros")
  print("Tak 20 10 0 is \(tarai(x: 20, y: 10, z: 0))")
}
