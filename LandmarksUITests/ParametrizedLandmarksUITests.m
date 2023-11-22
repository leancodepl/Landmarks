@import XCTest;
@import ObjectiveC.runtime;

@interface ParametrizedLandmarksUITests : XCTestCase
@end

@implementation ParametrizedLandmarksUITests
//- (instancetype)init {
//  NSLog(@"Called init");
//  return [super init];
//}
//
- (instancetype)initWithSelector:(SEL)selector {
  // NSLog(@"Called initWithSelector with arg: %@",
  // NSStringFromSelector(selector));
  return [super initWithSelector:selector];
}

// Called when running all tests
+ (XCTestSuite *)defaultTestSuite {
  NSLog(@"DBG: Called defaultTestSuite");
  // NSLog(@"DBG: %@", NSThread.callStackSymbols);
  return [super defaultTestSuite];
}

// Called when -only-testing is specified.
+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
  NSLog(@"DBG: Called instancesRespondToSelector with arg: %@",
        NSStringFromSelector(aSelector));
  // NSLog(@"DBG: %@", NSThread.callStackSymbols);

  return [super respondsToSelector:aSelector];
}

+ (NSArray<NSInvocation *> *)testInvocations {
  NSLog(@"DBG: testInvocations() called");
  // NSLog(@"DBG: %@", NSThread.callStackSymbols);

  /* Prepare dummy input */
  __block NSMutableArray<NSString *> *dartTestFiles =
      [[NSMutableArray alloc] init];
  [dartTestFiles addObject:@"example_test"];
  [dartTestFiles addObject:@"permissions_location_test"];
  [dartTestFiles addObject:@"permissions_many_test"];

  NSMutableArray<NSInvocation *> *invocations = [[NSMutableArray alloc] init];

  NSLog(@"Before the loop, %lu elements in the array",
        (unsigned long)dartTestFiles.count);

  for (int i = 0; i < dartTestFiles.count; i++) {
    /* Step 1 */

    NSString *name = dartTestFiles[i];

    void (^anonymousFunc)(ParametrizedLandmarksUITests *) =
        ^(ParametrizedLandmarksUITests *instance) {
          NSLog(@"anonymousFunc called!");
          // XCTFail(@"This is a custom message from test: %@ \n\n\n and this is
          // a newline", name); XCTAssertTrue(NO, @"%@", @"test name is %@
          // \n\n\n newline", name);
        };

    IMP implementation = imp_implementationWithBlock(anonymousFunc);
    NSString *selectorStr = [NSString stringWithFormat:@"%@", name];
    SEL selector = NSSelectorFromString(selectorStr);
    class_addMethod(self, selector, implementation, "v@:");

    /* Step 2 */

    NSMethodSignature *signature =
        [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation =
        [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;

    NSLog(@"RunnerUITests.testInvocations(): selectorStr = %@", selectorStr);

    [invocations addObject:invocation];
  }

  NSLog(@"After the loop");

  return invocations;
}

@end
