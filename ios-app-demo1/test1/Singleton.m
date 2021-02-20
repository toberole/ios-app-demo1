#import "Singleton.h"

@implementation Singleton
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static id shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    
    return shareInstance;
}
@end
