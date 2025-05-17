@preconcurrency import Foundation
import AcFoundation

private let main: () = {
     do { try Answer() } catch { /* WA */  }
}()

@MainActor
@inlinable
public func Answer() throws {
    print("Hello, STDERR!", to: &stderr)
    fastPrint([1,2,3])
}
