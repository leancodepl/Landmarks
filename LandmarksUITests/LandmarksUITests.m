#import <XCTest/XCTest.h>

@interface LandmarksUITests : XCTestCase

@end

@implementation LandmarksUITests

- (void)testFavorite {
  XCUIApplication *app = [[XCUIApplication alloc] init];
  [app launch];

  XCUIElementQuery *element = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingIdentifier:@"Turtle Rock"];
  [[element firstMatch] tap];
}

- (void)testFavoriteUsingPredicates {
  XCUIApplication *app = [[XCUIApplication alloc] init];
  [app launch];

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

  XCTAssertTrue(element.exists);
}

@end
