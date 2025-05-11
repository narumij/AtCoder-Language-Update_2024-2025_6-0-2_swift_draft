import AcFoundation

@inline(__always)
func _fastPrint<I>(_ x: I) where I: FixedWidthInteger & SignedInteger {
  var x = x
  
  // ---------- sign ----------
  if x < 0 {
    putchar_unlocked(Int32(45))      // '-'
    x = -x
  }
  
  // ---------- digits ----------
  // 20 bytes is enough for `Int.max` on 64-bit (+ sign)
  withUnsafeTemporaryAllocation(of: UInt8.self, capacity: 20) { buf in
    var i = 0
    repeat {
      let q = x / 10
      let r = x - q * 10           // avoid '%' which is slower
      buf[i] = UInt8(48 + r)       // store digit
      i += 1
      x = q
    } while x > 0
    
    // output in reverse order
    while i > 0 {
      i -= 1
      putchar_unlocked(Int32(buf[i]))
    }
  }
}

@inline(__always)
func _fastPrint<I>(_ x: I) where I: FixedWidthInteger & UnsignedInteger {
  var x = x
  
  // ---------- digits ----------
  // 20 bytes is enough for `Int.max` on 64-bit (+ sign)
  withUnsafeTemporaryAllocation(of: UInt8.self, capacity: 20) { buf in
    var i = 0
    repeat {
      let q = x / 10
      let r = x - q * 10           // avoid '%' which is slower
      buf[i] = UInt8(48 + r)       // store digit
      i += 1
      x = q
    } while x > 0
    
    // output in reverse order
    while i > 0 {
      i -= 1
      putchar_unlocked(Int32(buf[i]))
    }
  }
}


@inline(__always)
func fastPrint<I>(_ x: I) where I: FixedWidthInteger & SignedInteger {
  _fastPrint(x)
  // ---------- terminater ----------
  putchar_unlocked(Int32(10)) // '\n' or ' '
}

@inline(__always)
func fastPrint<I>(_ x: I) where I: FixedWidthInteger & UnsignedInteger {
  _fastPrint(x)
  // ---------- terminater ----------
  putchar_unlocked(Int32(10)) // '\n' or ' '
}

@inline(__always)
func fastPrint<C,I>(_ a: C) where C: Collection, C.Element == I, I: FixedWidthInteger & SignedInteger {
  for (idx, x) in a.enumerated() {
    _fastPrint(x)
    // ---------- separator ----------
    putchar_unlocked(idx == a.count - 1 ? Int32(10) : Int32(32)) // '\n' or ' '
  }
}

@inline(__always)
func fastPrint<C,I>(_ a: C) where C: Collection, C.Element == I, I: FixedWidthInteger & UnsignedInteger {
  for (idx, x) in a.enumerated() {
    _fastPrint(x)
    // ---------- separator ----------
    putchar_unlocked(idx == a.count - 1 ? Int32(10) : Int32(32)) // '\n' or ' '
  }
}
