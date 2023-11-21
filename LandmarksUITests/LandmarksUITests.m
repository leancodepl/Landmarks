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
  XCUIElementQuery *element = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  [[element firstMatch] tap];

  // Mark landmark as favorite
  predicate = [NSPredicate predicateWithFormat:@"identifier = %@", @"favorite"];
  element = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  [[element firstMatch] tap];

  // Go to landmarks list
  predicate = [NSPredicate predicateWithFormat:@"label = %@", @"Landmarks"];
  element = [[app descendantsMatchingType:XCUIElementTypeAny]
      matchingPredicate:predicate];
  [[element firstMatch] tap];

  // Assert that landmark is favorited
}

@end
