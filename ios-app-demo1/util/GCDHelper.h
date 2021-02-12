#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDHelper : NSObject

+(GCDHelper*)shareInstance;

-(void)dispatchAsyncMainQueue:(dispatch_block_t)block;

-(void)dispatchSyncMainQueue:(dispatch_block_t)block;

-(void)dispatchAsyncGlobalQueue:(dispatch_block_t)block;

-(void)dispatchSyncGlobalQueue:(dispatch_block_t)block;

-(void)dispatchSync:(dispatch_block_t)block serial:(BOOL)is_serial;

-(void)dispatchAsync:(dispatch_block_t)block serial:(BOOL)is_serial;

@end

NS_ASSUME_NONNULL_END
