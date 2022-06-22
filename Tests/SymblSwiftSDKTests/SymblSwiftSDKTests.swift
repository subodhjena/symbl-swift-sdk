import XCTest
@testable import SymblSwiftSDK

final class SymblSwiftSDKTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Symbl(accessToken: "ACCESS_TOKEN").accessToken, "ACCESS_TOKEN")
    }
}
