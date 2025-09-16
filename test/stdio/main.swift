import Foundation
import IOUtil

private let main: () = {
     do { try Answer() } catch { /* WA */  }
}()

@inlinable
public func Answer() throws {
    print("Hello, STDERR!", to: &FileOutputStream.standardError)
    fastPrint([1,2,3])
}
