#import "NBStu.h"

@interface NBStu ()

@property (nonatomic,strong)NSString*name;

@end

@implementation NBStu

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = nil;
    }
    return self;
}

+ (instancetype)initWithName:(NSString *)name{
    NBStu*stu = [[NBStu alloc]init];
    stu.name = name;
    return stu;
}

- (void)sysHello{
    NSLog(@"sysHello name: %@,test_name: %@",self.name,self.test_name);
}

@end
