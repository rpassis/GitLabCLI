import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(gitlab_cliTests.allTests),
    ]
}
#endif