#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeMutableArray : NSObject

- (void)addObject:(id)anObject;

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)removeLastObject;

- (void)removeObjectAtIndex:(NSUInteger)index;

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (id)objectAtIndex:(NSUInteger)index;

- (nullable id)getFirstObject;

- (nullable id)getLastObject;

@end

NS_ASSUME_NONNULL_END
