#import "TestWrapper.h"
#include "test.h"
#include <dlfcn.h>

@implementation TestWrapper

- (void)test1{
    int n = demo3_test1();
    NSLog(@"TestWrapper demo3_test1: %i",n);
}

- (void)test2{
    const char*msg = demo3_test2();
    NSLog(@"demo3_test2: %s",msg);
}

@end
