#import "Queue.h"

@interface Queue ()

@property (nonatomic,strong)NSMutableArray* arr;

@end

@implementation Queue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _arr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)enqueue:(id)obj{
    @synchronized (self) {
        [self.arr addObject:obj];
    }
}

- (id)dequeue{
    @synchronized (self) {
        if ([self.arr count]<0)return nil;
        
        id ret = [self.arr objectAtIndex:0];
        [self.arr removeObjectAtIndex:0];
        return ret;
    }
}

- (void)removeAllObjects{
    @synchronized (self) {
        [self.arr removeAllObjects];
    }
}

@end
