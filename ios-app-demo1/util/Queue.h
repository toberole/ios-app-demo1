#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Queue : NSObject

-(void)enqueue:(id)obj;

-(id)dequeue;

-(void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
