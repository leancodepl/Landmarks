import Quick
import XCTest

class QuickLandmarksUITests: QuickSpec {
  override class func spec() {
    it("testA") {
      NSLog("Executed test A")
      XCTAssertTrue(true)
    }

    it("testB") {
      NSLog("Executed test B")
      XCTAssertTrue(true)
    }
  }
}
