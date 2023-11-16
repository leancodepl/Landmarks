@import XCTest;

@interface StandardUITests : XCTestCase
@end

@implementation StandardUITests
- (void)alphaExampleTest {
    XCUIApplication *app =  [[XCUIApplication alloc] init];
    [app launch];
    XCTFail(@"alpha test was destined to fail, muahaha");
}


- (void)bravoExampleTest {
    XCUIApplication *app =  [[XCUIApplication alloc] init];
    [app launch];
}

@end
