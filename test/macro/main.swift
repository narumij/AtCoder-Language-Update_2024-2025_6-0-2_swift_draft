import Foundation
import swift_ac_memoize


private let main: () = {
  do { try Answer() } catch { /* WA */  }
}()

@MainActor
@inlinable
public func Answer() throws {
  print("Hello, Swift Macros")
  try Macro0()
}

@MainActor
public func Macro0() throws {
  let (a,b) = (2,3)
  let (result, code) = #stringify(a + b)
  print("The value \(result) was produced by the code \"\(code)\"")

}
