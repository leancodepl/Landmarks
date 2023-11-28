import Quick
import XCTest

class QuickLandmarksUITests: QuickSpec {
  override class func instancesRespond(to aSelector: Selector!) -> Bool {
    NSLog("instancesRespondTo: \(aSelector)")
    return super.instancesRespond(to: aSelector)
  }
  
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

