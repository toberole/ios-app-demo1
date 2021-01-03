#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface POPAnimation : NSObject
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;


@end

NS_ASSUME_NONNULL_END
