#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN

#define MIN_SIZE_PER_FRAME 2000
#define QUEUE_BUFFER_SIZE 3     //队列缓冲个数

@interface AudioQueuePlay : NSObject

// 播放并顺带附上数据
- (void)playWithData: (NSData *)data;

// reset
- (void)resetPlay;



@end


NS_ASSUME_NONNULL_END
