#import "SingleToneTest.h"

@interface SingleToneTest ()

@property(nonatomic,strong)SingleToneTest*instance;

@end

@implementation SingleToneTest

- (SingleToneTest *)getInstance{
    dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!_instance) {
            _instance = [[SingleToneTest alloc]init];
        }
    });
    
    return _instance;
}

@end
