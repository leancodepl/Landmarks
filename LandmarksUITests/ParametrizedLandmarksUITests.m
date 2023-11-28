@import XCTest;
@import ObjectiveC.runtime;

@interface ParametrizedLandmarksUITests : XCTestCase
@end

@implementation ParametrizedLandmarksUITests

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
    NSString *name = dartTestFiles[i];
    NSInvocation  *invocation = [self createInvocationWithName:name];
    [invocations addObject:invocation];
  }

  NSLog(@"After the loop");

  return invocations;
}

+ (NSInvocation*)createInvocationWithName:(NSString *)name {
  void (^block)(ParametrizedLandmarksUITests *) = ^(ParametrizedLandmarksUITests *instance) {
    NSLog(@"Test method for %@ called!", name);
  };
  
  IMP implementation = imp_implementationWithBlock(block);
  NSString *selectorStr = [NSString stringWithFormat:@"test_%@", name];
  SEL selector = NSSelectorFromString(selectorStr);
  class_addMethod(self, selector, implementation, "v@:");
  
  NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
  invocation.selector = selector;
  return invocation;
}

@end
