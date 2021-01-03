#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioQueuePlay : NSObject

// 播放并顺带附上数据
- (void)playWithData: (NSData *)data;

// reset
- (void)resetPlay;

@end


NS_ASSUME_NONNULL_END
