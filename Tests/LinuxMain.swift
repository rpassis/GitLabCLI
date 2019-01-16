import XCTest

import gitlab_cliTests

var tests = [XCTestCaseEntry]()
tests += gitlab_cliTests.allTests()
XCTMain(tests)