import AcFoundation

private let main: () = {
    // 5.8.1では、nonisoletedなmain関数からMainActorを呼び出せなかったが、
    // 6.0.3では呼び出せるようになっている
     do { try Answer() } catch { /* WA */  }
}()

@MainActor
@inlinable
public func Answer() throws {
    print("Hello, STDERRO!", to: &stderr)
}
