import Foundation

// 以下のコードをお借りしています。
// https://atcoder.jp/contests/abc235/submissions/28574875

let main: () = {
//    printErr("Ready!")
    let (A, N) = *listOfInt()
    func nextX(_ x: Int) -> Int {
        let s = "\(x)"
        let ns = s.last!.string + s.left(s.count - 1)
        let nx = ns.int
        return nx
    }
    let maxN = min(10_000_010, N * 10)
    var dp = IntArray(maxN + 2) { -1 }
    dp[1] = 0
    var Q = [1]
    while !Q.isEmpty {
        let n = Q.removeLast()
        if dp[n] != -1 {
            let x = n * A
            if x <= maxN {
                if dp[x] == -1 || dp[x] > dp[n] + 1 {
                    dp[x] = dp[n] + 1
                    Q += x
                }
            }
            if n > 10 && !n.isMultiple(of: 10) {
                let x = nextX(n)
                if x <= maxN {
                    if dp[x] == -1 || dp[x] > dp[n] + 1 {
                        dp[x] = dp[n] + 1
                        Q += x
                    }
                }
            }
        }
    }
    print(dp[N])
//print(dp)
//print(dp.enumerated().filter({$0.element != -1}).forEach({ print($0) }))
}()












































































































@inlinable func printYes() { print("Yes") }
@inlinable func printNo() { print("No") }
@inlinable func printYesNo(_ f: Bool) { f ? printYes() : printNo() }

/*  @discardableResult
 
func isInside(_ row: Int, _ col: Int) -> Bool {
    guard 0 <= row && row < H else { return false }
    guard 0 <= col && col < W else { return false }
    return G[row][col]
}

struct CDType: Hashable, Comparable {
    let c: Int
    let d: Int
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.c < rhs.c && lhs.d < rhs.d
    }
    init(_ a: Int, _ b: Int) {
        (c, d) = (a, b)
    }
    init(_ cd: (Int, Int)) {
        (c, d) = (cd.0, cd.1)
    }
}

//----------------------------------

for n in stride(from: 1, through: N, by: 2) { } // 1...N step 2
for n in stride(from: 0, to: N, by: 3) { } // 0..<N step 3

var G = [[Int]](repeating: [Int](repeating: 0, count: W), count: H)
var G = [[Bool]](repeating: [Bool](repeating: true, count: W), count: H)
var array2D = [[Int]](repeating: [Int](), count: N) //mutable
var array3D = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating:0, count: N), count: N), count: N)

let Letters = "abcdefghijklmnopqrstuvwxyz"
let Letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let Number = "0123456789"

let x: Int? = MAX / B >= A ? A * B : nil    //check overflow

//----------------------------------

let dx = [1, 0, -1, 0] //[1, 0, -1, 0, -1,  1, -1, 1]
let dy = [0, 1, 0, -1] //[0, 1, 0, -1, -1, -1,  1, 1]
let dm = ["D", "R", "U", "L"]

*/

@inlinable func gcd(_ a: Int, _ b: Int) -> Int { (b > 0) ? gcd(b, a % b) : a }
@inlinable func lcm(_ a: Int, _ b: Int) -> Int { a / gcd(a, b) * b }

//----------------------------------

@inlinable func Array2D<T: StringProtocol>(rows: Int, columns: Int, initialValue: T = "") -> [[T]] {
    [[T]](repeating: [T](repeating: initialValue, count: columns), count: rows)
}
@inlinable func Array2D<T: ExpressibleByIntegerLiteral>(rows: Int, columns: Int, initialValue: T = 0) -> [[T]] {
    [[T]](repeating: [T](repeating: initialValue, count: columns), count: rows)
}
@inlinable func Array2D<T: ExpressibleByIntegerLiteral>(rows: Int, columns: Int, initialValue: (Int, Int) -> T) -> [[T]] {
    var array2d = [[T]](repeating: [T](repeating: 0, count: columns), count: rows)
    for row in 0 ..< rows {
        for col in 0 ..< columns { array2d[row][col] = initialValue(row, col) }
    }
    return array2d
}
@inlinable func Array2D<T>(rows: Int, columnsValue: (Int) -> [T] ) -> [[T]] {
    var array2d = [[T]](repeating: [T](), count: rows)
    for row in 0 ..< rows { array2d[row] = columnsValue(row) }
    return array2d
}

//----------------------------------

infix operator ** : MultiplicationPrecedence
func ** <T: FixedWidthInteger>(n: T, m: T) -> T { // n ** m
    (m == 0) ? 1 : (1 ... m).reduce(1, { a, v in a * n })
}

infix operator  =~ : ComparisonPrecedence
infix operator !=~ : ComparisonPrecedence
// n =~ 0 ..< N
func  =~ <T: FixedWidthInteger>(left: T, right: Range<T>) -> Bool { right ~= left }
func !=~ <T: FixedWidthInteger>(left: T, right: Range<T>) -> Bool { !(right ~= left) }
func  =~ <T: FixedWidthInteger>(left: T, right: ClosedRange<T>) -> Bool { right ~= left }
func !=~ <T: FixedWidthInteger>(left: T, right: ClosedRange<T>) -> Bool { !(right ~= left) }
// n =~ X<Array/Set>
func  =~ <T: Collection > (left: T.Element, right: T) -> Bool where T.Element : Equatable { right.contains(left) }
func !=~ <T: Collection > (left: T.Element, right: T) -> Bool where T.Element : Equatable { !right.contains(left) }

infix operator /^  : MultiplicationPrecedence
infix operator /^= : AssignmentPrecedence
func /^  <T: FixedWidthInteger>(left: T, right: T) -> T { (left + (right - 1)) / right }
func /^= <T: FixedWidthInteger>(left: inout T, right: T) { left = (left + (right - 1)) / right }

//@inlinable func chmax<T: Comparable>(_ m: inout T, _ q: T) { if (m < q) { m = q } }
//@inlinable func chmin<T: Comparable>(_ m: inout T, _ q: T) { if (m > q) { m = q } }
@inlinable @discardableResult func chmax<T: Comparable>(_ m: inout T, _ q: T) -> Bool { if (m < q) { m = q; return true } else { return false } }
@inlinable @discardableResult func chmin<T: Comparable>(_ m: inout T, _ q: T) -> Bool { if (m > q) { m = q; return true } else { return false } }

prefix operator * // array to tupple
prefix func * <T> (a: [T]) -> (T, T) { (a[0], a[1]) }
prefix func * <T> (a: [T]) -> (T, T, T) { (a[0], a[1], a[2]) }
prefix func * <T> (a: [T]) -> (T, T, T, T) { (a[0], a[1], a[2], a[3]) }
prefix func * <T> (a: [T]) -> (T, T, T, T, T) { (a[0], a[1], a[2], a[3], a[4]) }
prefix func * <T> (a: [T]) -> (T, T, T, T, T, T) { (a[0], a[1], a[2], a[3], a[4], a[5]) }

extension Array where Element == String { //string array to tupple
    @inlinable func toIntDouble() -> (Int, Double) { (Int(self[0])!, Double(self[1])!) }
    @inlinable func toIntString() -> (Int, String) { (Int(self[0])!, self[1]) }
    @inlinable func toIntIntString() -> (Int, Int, String) { (Int(self[0])!, Int(self[1])!, self[2]) }
}

func printErr(_ str: String, terminator: String = "\n") {
    let string = str + terminator
    FileHandle.standardError.write(string.data(using: .utf8)!)
    FileHandle.standardError.synchronizeFile()
}

@inlinable func next() -> String { readLine()! }
@inlinable func nextString() -> [String] { next().map { String($0) } }
@inlinable func nextInt() -> Int { Int(next())! }
@inlinable func nextDouble() -> Double { Double(next())! }
@inlinable func listOfString() -> [String] { next().split(separator: " ").map(String.init) }
@inlinable func listOfInt() -> [Int] { listOfString().map { Int($0)! } }
@inlinable func listOfInt(_ offset: Int = 0) -> [Int] { listOfString().map { Int($0)! + offset } }
@inlinable func listOfInt(_ offsets: Int ...) -> [Int] { listOfString().enumerated().map { Int($0.element)! + offsets[$0.offset % offsets.count] } }
@inlinable func listOfDouble(_ offset: Double = 0.0) -> [Double] { listOfString().map { Double($0)! + offset } }
@inlinable func listOfDouble(_ offsets: Double ...) -> [Double] { listOfString().enumerated().map { Double($0.element)! + offsets[$0.offset % offsets.count] } }

extension Int {
    init(s: String) { self.init(s)! }
    @inlinable var isEven: Bool { self.isMultiple(of: 2) }
    @inlinable var isOdd: Bool { !self.isEven }
    @inlinable var isTrue: Bool { self != 0 }
    @inlinable var isFalse: Bool { !self.isTrue }
    @inlinable var string: String { String(self) }
    @inlinable var char: Character { Character(UnicodeScalar(UInt8(self))) }
    @inlinable var double: Double { Double(self) }
    @inlinable var indices: Range<Int> { (0 ..< self) }
    @inlinable var indicesReversed: ReversedCollection<Range<Int>> { self.indices.reversed() }
    @inlinable var log2: Int { self == 0 ? -1 : (Self.bitWidth - (self - 1).leadingZeroBitCount) }
    @inlinable func isOn(_ n: Int) -> Bool { ((self >> n) & 1).isTrue }
    
    static func + (left: Int, right: Bool) -> Int { left + right.int }
}
extension Bool {
    @inlinable var int: Int { self ? 1 : 0 }
}
extension Double {
    @inlinable var int: Int { Int(self) }
    @inlinable var string: String { String(format: "%.10f", self) }
    @inlinable var floor: Double { Foundation.floor(self) }
    @inlinable var ceil: Double { Foundation.ceil(self) }
}
extension Character {
    @inlinable var asciiCode: Int { Int(self.asciiValue!) }
    @inlinable var string: String { String(self) }
}
extension String {
    @inlinable subscript (position: Int) -> Character { self[self.index(self.startIndex, offsetBy: position)] }
    @inlinable func `repeat`(_ times: Int) -> String { String(repeating: self, count: times) }
    @inlinable var int: Int { Int(self)! }
}
extension String { // VB like
    // "ABCDEFG".mid(3, 4) -> "CDEF"
    @inlinable func mid(_ index: Int, _ length: Int) -> String {
        self.left(index + length - 1).right(length)
    }
    @inlinable func left(_ length: Int) -> String { String(self.prefix(length)) }
    @inlinable func right(_ length: Int) -> String { String(self.suffix(length)) }
}
extension String {
    @inlinable var lowercaseLettersToIntArray: [Int] { self.map { $0.asciiCode - 97 } }
    @inlinable var uppercaseLettersToIntArray: [Int] { self.map { $0.asciiCode - 65 } }
    @inlinable var numberStringToIntArray: [Int] { self.map { $0.asciiCode - 48 } }
}
extension String { // substring系
// let string = "0123456789"
// string[0...5] //=> "012345"
// string[1...3] //=> "123"
// string[3..<7] //=> "3456"
// string[...4]  //=> "01234
// string[..<4]  //=> "0123"
// string[4...]  //=> "456789"
    subscript(bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript(bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    subscript(bounds: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex..<end])
    }
    
    subscript(bounds: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex...end])
    }
    
    subscript(bounds: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        return String(self[start..<endIndex])
    }
}

extension Array where Element == Int {
    @inlinable var lowercaseToString: String { String(self.map { ($0 + 97).char }) }
    @inlinable var uppercaseToString: String { String(self.map { ($0 + 65).char }) }
    @inlinable var numerToString: String { String(self.map { ($0 + 48).char }) }
}

extension Dictionary {
    @inlinable func contains(key: Key) -> Bool { self.keys.contains(key) }
}
extension Dictionary where Value == Int {
    @inlinable mutating func addValue(forKey key: Key, add: Int, removeRequire: Bool = true) {
        self[key, default: 0] += add
        if removeRequire && self[key, default: 0] <= 0 { self.removeValue(forKey: key) }
    }
}
extension Dictionary where Key: Comparable {
    @inlinable func sortedByKey() -> [(key: Key, value: Value)] { self.sorted(by: { $0.key < $1.key }) }
}

extension Array {
    @inlinable func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
        var dict = [Key: Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
extension Sequence {
    @inlinable func toDictionary<Key: Hashable, Value>(with keyValue: (Element) -> (Key, Value)) -> [Key: Value] {
        var dict = [Key: Value]()
        for element in self {
            let tapple = keyValue(element)
            dict[tapple.0] = tapple.1
        }
        return dict
    }
}


extension ArraySlice {
    var array: Array<Element> { Array(self) }
}
extension Substring {
    var string: String { String(self) }
}

extension Set {
    static func += (left: inout Set<Element>, right: Element) { left.insert(right) }
    static func -= (left: inout Set<Element>, right: Element) { left.remove(right) }
}

extension Array {
    @inlinable var second: Element? { self.count >= 2 ? self[1] : nil }
    @inlinable var third: Element? { self.count >= 3 ? self[2] : nil }
    static func += (left: inout Array<Element>, right: Element) { left.append(right) }
    init(_ size: Int, _ initValue: ((Int) -> Element)) {
        self = [Element]()
        for index in 0 ..< size {
            let value = initValue(index)
            self.append(value)
        }
    }
    init(_ size: Int, _ initValue: (() -> Element)) {
        self = [Element]()
        for _ in 0 ..< size {
            let value = initValue()
            self.append(value)
        }
    }
}
typealias IntArray = Array<Int>
typealias DoubleArray = Array<Double>
typealias BoolArray = Array<Bool>
typealias StringArray = Array<String>

extension Array where Element == Int {
    init(_ size: Int) {
        self = [Element](repeating: 0, count: size)
    }
}
extension Array where Element == Double {
    init(_ size: Int) {
        self = [Element](repeating: 0.0, count: size)
    }
}
extension Array where Element == Bool {
    init(_ size: Int) {
        self = [Element](repeating: false, count: size)
    }
}
extension Array where Element == String {
    init(_ size: Int) {
        self = [Element](repeating: "", count: size)
    }
}

extension Array {
    @inlinable func sum(by predicate: (Element) -> Int) -> Int {
        var total = 0
        for element in self { total += predicate(element) }
        return total
    }
    @inlinable func any(_ predicate: (Element) -> Bool) -> Bool {
        for element in self { if predicate(element) { return true } }
        return false
    }
    @inlinable func all(_ predicate: (Element) -> Bool) -> Bool { self.allSatisfy(predicate) }
    @inlinable func count(by predicate: ((Element) -> Bool)) -> Int {
        var cnt = 0
        for element in self { if (predicate(element)) { cnt += 1 } }
        return cnt
    }
    @inlinable func groupBy<K>(_ keySelector: (Element) -> K) -> [K : [Element]] {
        var destination = [K : [Element]]()
        for element in self {
            let key = keySelector(element)
            var list = destination[key, default: []]
            list.append(element)
            destination[key] = list
        }
        return destination
    }
    @inlinable func groupByIndexed<K>(_ keySelector: (Element) -> K) -> [K : [Int]] {
        var destination = [K : [Int]]()
        for element in self.enumerated() {
            let key = keySelector(element.element)
            var list = destination[key, default: []]
            list.append(element.offset)
            destination[key] = list
        }
        return destination
    }
}
extension Array where Element: Hashable {
    @inlinable func distinct() -> [Element] {
        var set = Set<Element>(), ary = [Element]()
        for n in self.indices {
            if !set.contains(self[n]) { ary.append(self[n]); set.insert(self[n]) }
        }
        return ary
    }
    @inlinable func groupBy() -> [Element: Int] {
        var result = [Element: Int]()
        self.forEach { result[$0, default: 0] += 1 }
        return result
    }
}
extension Array {
    func binarySearch(_ element: Element, by compare: (Element, Element) -> Int, fromIndex: Int = 0, toIndex: Int = -1) -> Int {
        var low = fromIndex
        var high = (toIndex == -1) ? self.count - 1 : toIndex - 1
        while low <= high {
            let mid = (low + high) >> 1 // safe from overflows
            let midVal = self[mid]
            let cmp = compare(midVal, element)
            if cmp < 0 { low = mid + 1 }          //-1
            else if 0 < cmp { high = mid - 1 }    // 1
            else { return mid } // key found      // 0
        }
        return -(low + 1)  // key not found
    }
}
extension Array where Element : Comparable {
    func binarySearch(_ element: Element, fromIndex: Int = 0, toIndex: Int = -1) -> Int {
        var low = fromIndex
        var high = (toIndex == -1) ? self.count - 1 : toIndex - 1
        while low <= high {
            let mid = (low + high) >> 1 // safe from overflows
            let midVal = self[mid]
            if midVal < element { low = mid + 1 }
            else if midVal > element { high = mid - 1 }
            else { return mid } // key found
        }
        return -(low + 1)  // key not found
    }
}

extension Array where Element == Int {
    @inlinable func sum() -> Element { self.reduce(0, +) }
    @inlinable func sum(by predicate: (Element) -> Element) -> Element {
        var total = 0
        for element in self { total += predicate(element) }
        return total
    }
    @inlinable func joinToString(_ sepatator: String = " ") -> String {
        self.map { String($0) }.joined(separator: sepatator)
    }
    @inlinable var median: Int {
        let m = self.count / 2
        if self.count.isOdd {
            return self[m]
        } else {
            let m1 = self[m - 1]
            let m2 = self[m]
            return (m1 + m2) / 2
        }
    }
    
}
extension Array where Element == Double {
    @inlinable func sum() -> Element { self.reduce(0.0, +) }
    @inlinable func sum(by predicate: (Element) -> Element) -> Element {
        var total = 0.0
        for element in self { total += predicate(element) }
        return total
    }
    @inlinable func joinToString(_ sepatator: String = " ") -> String {
        self.map { String(format: "%.10f", $0) }.joined(separator: sepatator)
    }
}

extension Array where Element == [Int] {
    @inlinable subscript(_ row: Int, _ col: Int) -> Int {
        get {
            //precondition(0 <= row && row < self.count)
            //precondition(0 <= col && col < self[row].count)
            return self[row][col]
        }
        set {
            //precondition(0 <= row && row < self.count)
            //precondition(0 <= col && col < self[row].count)
            self[row][col] = newValue
        }
    }
}
extension Array where Element == [Double] {
    @inlinable subscript(_ row: Int, _ col: Int) -> Double {
        get { return self[row][col] }
        set { self[row][col] = newValue }
    }
}
extension Array where Element == [String] {
    @inlinable subscript(_ row: Int, _ col: Int) -> String {
        get { return self[row][col] }
        set { self[row][col] = newValue }
    }
}
extension Array where Element == [Bool] {
    @inlinable subscript(_ row: Int, _ col: Int) -> Bool {
        get { return self[row][col] }
        set { self[row][col] = newValue }
    }
}

/*
@inlinable func block( _ action: () -> Void) {
    action()
}
@inlinable func block(repeat times1: Int, _ action: () -> Void) {
    for _ in 0 ..< times1 { action() }
}
@inlinable func block(repeat times1: Int, _ action: (Int) -> Void) {
    for index1 in 0 ..< times1 {
        action(index1)
    }
}
@inlinable func block(repeat times1: Int, _ times2: Int, _ action: (Int, Int) -> Void) {
    for index1 in 0 ..< times1 {
        for index2 in 0 ..< times2 {
            action(index1, index2)
        }
    }
}
@inlinable func block(repeat times1: Int, _ times2: Int, _ times3: Int, _ action: (Int, Int, Int) -> Void) {
    for index1 in 0 ..< times1 {
        for index2 in 0 ..< times2 {
            for index3 in 0 ..< times3 {
                action(index1, index2, index3)
            }
        }
    }
}
@inlinable func block(repeat times1: Int, _ times2: Int, _ times3: Int, _ times4: Int, _ action: (Int, Int, Int, Int) -> Void) {
    for index1 in 0 ..< times1 {
        for index2 in 0 ..< times2 {
            for index3 in 0 ..< times3 {
                for index4 in 0 ..< times4 {
                    action(index1, index2, index3, index4)
                }
            }
        }
    }
}
*/

func measureTimeSeconds(block: (() -> Void)) -> Double {
    let startTime = Date()
    block()
    let duration = -startTime.timeIntervalSinceNow
    return duration
}


















































































