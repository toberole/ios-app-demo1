#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
