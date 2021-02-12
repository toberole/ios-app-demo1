#import "GCDHelper.h"

static dispatch_queue_t main_q;
static dispatch_queue_t global_q;
// 并发队列 的并发功能只有在异步（dispatch_async）方法下才有效。
static dispatch_queue_t custom_q_concurrent;
static dispatch_queue_t custom_q_serial;

static GCDHelper*instance = nil;

@interface GCDHelper ()

@end

@implementation GCDHelper

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!main_q) {
            main_q = dispatch_get_main_queue();
        }
        
        if (!global_q) {
            global_q = dispatch_get_global_queue(DISPATCH_TARGET_QUEUE_DEFAULT, 0);
        }
        
        if (!custom_q_concurrent) {
            custom_q_concurrent = dispatch_queue_create("custom_q_concurrent", DISPATCH_QUEUE_CONCURRENT);
        }
        
        if (!custom_q_serial) {
            custom_q_serial = dispatch_queue_create("custom_q_serial", DISPATCH_QUEUE_SERIAL);
        }
        
       instance = [super allocWithZone:zone];
    });
    return instance;
}

+(GCDHelper*)shareInstance{
    return [[super alloc]init];
}

-(void)dispatchAsyncMainQueue:(dispatch_block_t)block{
    dispatch_async(main_q, block);
}

-(void)dispatchSyncMainQueue:(dispatch_block_t)block{
    dispatch_sync(main_q, block);
}

-(void)dispatchAsyncGlobalQueue:(dispatch_block_t)block{
    dispatch_async(global_q, block);
}

-(void)dispatchSyncGlobalQueue:(dispatch_block_t)block{
    dispatch_sync(global_q, block);
}

-(void)dispatchSync:(dispatch_block_t)block serial:(BOOL)is_serial{
    if (is_serial) {
        dispatch_sync(custom_q_serial, block);
    }else{
        dispatch_sync(custom_q_concurrent, block);
    }
}

-(void)dispatchAsync:(dispatch_block_t)block serial:(BOOL)is_serial{
    if (is_serial) {
        dispatch_async(custom_q_serial, block);
    }else{
        dispatch_async(custom_q_concurrent, block);
    }
}
@end
