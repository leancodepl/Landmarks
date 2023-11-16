@import XCTest;
@import ObjectiveC.runtime;

@interface ParametrizedTests : XCTestCase
@end

@implementation ParametrizedTests
+ (NSArray<NSInvocation *> *)testInvocations {
  NSLog(@"testInvocations() called");

  /* Prepare dummy input */
  __block NSMutableArray<NSString *> *dartTestFiles = [[NSMutableArray alloc] init];
  [dartTestFiles addObject:@"example_test"];
  [dartTestFiles addObject:@"permissions_location_test"];
  [dartTestFiles addObject:@"permissions_many_test"];

  NSMutableArray<NSInvocation *> *invocations = [[NSMutableArray alloc] init];

  NSLog(@"Before the loop, %lu elements in the array", (unsigned long)dartTestFiles.count);

  for (int i = 0; i < dartTestFiles.count; i++) {
    /* Step 1 */

    NSString *name = dartTestFiles[i];

    void (^anonymousFunc)(ParametrizedTests *) = ^(ParametrizedTests *instance) {
      NSLog(@"anonymousFunc called!");
      // XCTFail(@"This is a custom message from test: %@ \n\n\n and this is a newline", name);
      XCTAssertTrue(NO, @"%@", @"test name is %@ \n\n\n newline", name);
    };

    IMP implementation = imp_implementationWithBlock(anonymousFunc);
    NSString *selectorStr = [NSString stringWithFormat:@"test_%@", name];
    SEL selector = NSSelectorFromString(selectorStr);
    class_addMethod(self, selector, implementation, "v@:");

    /* Step 2 */

    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;

    NSLog(@"RunnerUITests.testInvocations(): selectorStr = %@", selectorStr);

    [invocations addObject:invocation];
  }

  NSLog(@"After the loop");

  return invocations;
}

@end
