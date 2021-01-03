#import "SafeMutableArray.h"

@interface SafeMutableArray()

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) dispatch_queue_t readWriteQuene;

@end

@implementation SafeMutableArray
- (instancetype)init {
   self = [super init];
   if (self) {
       _array = [NSMutableArray array];
       _readWriteQuene = dispatch_queue_create("SafeMutableArray.quene", DISPATCH_QUEUE_CONCURRENT);
   }
   return self;
}

- (void)addObject:(id)anObject {
   dispatch_barrier_async(self.readWriteQuene, ^{
       [self.array addObject:anObject];
   });
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
   dispatch_barrier_async(self.readWriteQuene, ^{
       [self.array insertObject:anObject atIndex:index];
   });
}

- (void)removeLastObject {
   dispatch_barrier_async(self.readWriteQuene, ^{
       [self.array removeLastObject];
   });
}

- (void)removeObjectAtIndex:(NSUInteger)index {
   dispatch_barrier_async(self.readWriteQuene, ^{
       [self.array removeObjectAtIndex:index];
   });
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
   dispatch_barrier_async(self.readWriteQuene, ^{
       [self.array replaceObjectAtIndex:index withObject:anObject];
   });
}

- (id)objectAtIndex:(NSUInteger)index {
   __block id item = nil;
   dispatch_sync(self.readWriteQuene, ^{
       if (index <= self.array.count - 1) {
           item = [self.array objectAtIndex:index];
       }
   });
   return item;
}
- (nullable id)getFirstObject {
   __block id item = nil;
   dispatch_sync(self.readWriteQuene, ^{
       if (self.array.count > 0) {
           item = [self.array objectAtIndex:0];
       }
   });
   return item;
}
- (nullable id)getLastObject {
   __block id item = nil;
   dispatch_sync(self.readWriteQuene, ^{
       NSUInteger size = self.array.count;
       if (size > 0) {
           item = self.array[size - 1];
       }
   });
   return item;
}

@end
