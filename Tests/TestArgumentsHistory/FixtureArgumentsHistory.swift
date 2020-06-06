import MockoloFramework

let argumentsHistorySimpleCase = """
/// \(String.mockAnnotation)
protocol Foo {
   func fooFunc()
   func barFunc(val: Int)
   func bazFunc(_ val: Int)
   func quxFunc(val: Int) -> String
   func quuxFunc(val1: String, val2: Float)
}
"""

let argumentsHistorySimpleCaseMock = """
class FooMock: Foo {
    init() { }

    var fooFuncCallCount = 0
    var fooFuncHandler: (() -> ())?
    func fooFunc() {
        fooFuncCallCount += 1
        
        if let fooFuncHandler = fooFuncHandler {
            fooFuncHandler()
        }
    }

    var barFuncCallCount = 0
    var barFuncValues = [Int]()
    var barFuncHandler: ((Int) -> ())?
    func barFunc(val: Int) {
        barFuncCallCount += 1
        barFuncValues.append(val)

        if let barFuncHandler = barFuncHandler {
            barFuncHandler(val)
        }
    }

    var bazFuncCallCount = 0
    var bazFuncValues = [Int]()
    var bazFuncHandler: ((Int) -> ())?
    func bazFunc(_ val: Int) {
        bazFuncCallCount += 1
        bazFuncValues.append(val)

        if let bazFuncHandler = bazFuncHandler {
            bazFuncHandler(val)
        }
    }

    var quxFuncCallCount = 0
    var quxFuncValues = [Int]()
    var quxFuncHandler: ((Int) -> (String))?
    func quxFunc(val: Int) -> String {
        quxFuncCallCount += 1
        quxFuncValues.append(val)

        if let quxFuncHandler = quxFuncHandler {
            return quxFuncHandler(val)
        }
        return ""
    }

    var quuxFuncCallCount = 0
    var quuxFuncValues = [(String, Float)]()
    var quuxFuncHandler: ((String, Float) -> ())?
    func quuxFunc(val1: String, val2: Float) {
        quuxFuncCallCount += 1
        quuxFuncValues.append((val1, val2))

        if let quuxFuncHandler = quuxFuncHandler {
            quuxFuncHandler(val1, val2)
        }
    }
}
"""

let argumentsHistoryInoutCase = """
/// \(String.mockAnnotation)
protocol Foo {
    func fooFunc(val: inout Int)
    func barFunc(into val: inout Int)
}
"""

let argumentsHistoryInoutCaseMock = """
class FooMock: Foo {
    init() { }

    var fooFuncCallCount = 0
    var fooFuncValues = [Int]()
    var fooFuncHandler: ((inout Int) -> ())?
    func fooFunc(val: inout Int) {
        fooFuncCallCount += 1
        fooFuncValues.append(val)

        if let fooFuncHandler = fooFuncHandler {
            fooFuncHandler(&val)
        }
    }
}
"""
