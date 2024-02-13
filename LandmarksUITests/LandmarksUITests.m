#import <XCTest/XCTest.h>

@interface LandmarksUITests : XCTestCase

@end

@implementation LandmarksUITests

- (void)testFavorite {
  NSLog(@"TESTLOG 1");

  XCUIApplication *app = [[XCUIApplication alloc] init];
  [app launch];

  NSLog(@"TESTLOG 2");

  XCUIElementQuery *element = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingIdentifier:@"Turtle Rock"];
  [[element firstMatch] tap];
}

- (void)testFavoriteUsingPredicates {
  NSLog(@"TESTLOG 3");
  XCUIApplication *app = [[XCUIApplication alloc] init];
  [app launch];

  NSLog(@"TESTLOG 4");

  // Open landmark page
  NSPredicate *predicate =
      [NSPredicate predicateWithFormat:@"label = %@", @"Turtle Rock"];
  XCUIElementQuery *query = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  [[query firstMatch] tap];

  // Mark landmark as favorite
  predicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"favorite"];
  query = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  [[query firstMatch] tap];

  // Go to landmarks list
  predicate = [NSPredicate predicateWithFormat:@"label = %@", @"Landmarks"];
  query = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  [[query firstMatch] tap];

  // Assert that landmark is favorited
  predicate = [NSPredicate
      predicateWithFormat:@"label = %@", @"Turtle Rock, favorited"];
  query = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  XCUIElement *element = query.allElementsBoundByIndex.firstObject;

  NSLog(@"TESTLOG 5");

  XCTAssertTrue(element.exists);
  NSLog(@"TESTLOG 6");
}

@end
