import Foundation
import AcFoundation

private let main: () = {
  do { try Answer() } catch { /* WA */  }
}()

@MainActor
@inlinable
public func Answer() throws {
  print("Hello, MainActor!")
  try Some()
}

@MainActor
@inlinable
public func Some() throws {
  print("Hello, MainActor Again!")
}
