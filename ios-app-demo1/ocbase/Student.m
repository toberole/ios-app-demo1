#import "Student.h"

@implementation Student

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

@end
