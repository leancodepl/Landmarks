@import XCTest;
@import ObjectiveC.runtime;

@interface ParametrizedLandmarksUITests : XCTestCase

@property (class, strong, nonatomic) NSString *selectedTest;

@end

@implementation ParametrizedLandmarksUITests

static NSString *_selectedTest = nil;

+ (NSString *)selectedTest {
  return _selectedTest;
}

+ (void)setSelectedTest:(NSString *)newSelectedTest {
  if (newSelectedTest != _selectedTest) {
    _selectedTest = [newSelectedTest copy];
  }
}

+ (BOOL)instancesRespondToSelector:(SEL)aSelector {
  NSLog(@"DBG: Called instancesRespondToSelector with arg: %@", NSStringFromSelector(aSelector));
  
  [self setSelectedTest:NSStringFromSelector(aSelector)];
  [self defaultTestSuite]; // calls testInvocations

  BOOL result = [super instancesRespondToSelector:aSelector];
  NSLog(@"DBG: instancesRespondToSelector will return: %d", result);
  return true;
}

+ (NSArray<NSInvocation *> *)testInvocations {
  NSLog(@"DBG: testInvocations() called");

  /* Prepare dummy input */
  __block NSMutableArray<NSString *> *dartTestFiles = [[NSMutableArray alloc] init];
  
  if ([[self class] selectedTest] != nil) {
    NSLog(@"DBG: selectedTest is not nil! It is: %@", [[self class] selectedTest]);
    [dartTestFiles addObject:[[self class] selectedTest]];
  } else {
    // TODO: Call HTTP method to populate selectors
    [dartTestFiles addObject:@"example_test"];
    [dartTestFiles addObject:@"permissions_location_test"];
    [dartTestFiles addObject:@"permissions_many_test"];
  }

  NSMutableArray<NSInvocation *> *invocations = [[NSMutableArray alloc] init];

  NSLog(@"Before the loop, %lu elements in dartTestFiles", (unsigned long)dartTestFiles.count);

  for (int i = 0; i < dartTestFiles.count; i++) {
    NSString *name = dartTestFiles[i];
    NSInvocation *invocation = [self createInvocationWithName:name];
    [invocations addObject:invocation];
  }

  NSLog(@"After the loop, %lu elements in invocations", (unsigned long)invocations.count);

  return invocations;
}

+ (NSInvocation*)createInvocationWithName:(NSString *)name {
  void (^block)(ParametrizedLandmarksUITests *) = ^(ParametrizedLandmarksUITests *instance) {
    NSLog(@"Test method for %@ called!", name);
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
  };
  
  IMP implementation = imp_implementationWithBlock(block);
  // NSString *selectorStr = [NSString stringWithFormat:@"test_%@", name];
  SEL selector = NSSelectorFromString(name);
  class_addMethod(self, selector, implementation, "v@:");
  
  NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
  invocation.selector = selector;
  return invocation;
}

@end
