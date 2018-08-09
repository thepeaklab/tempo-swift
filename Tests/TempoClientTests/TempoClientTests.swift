import XCTest
@testable import temposwift

final class temposwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(temposwift().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
