#import "BaseViewController.h"
#import "POPAnimation.h"


@interface BaseViewController ()

@property UIPercentDrivenInteractiveTransition*interactiveTransition;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self; // 设置navigationController的代理为self,并实现其代理方法
    
    self.view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backHandle:)];
    [self.view addGestureRecognizer:panGesture];
}


- (void)backHandle:(UIPanGestureRecognizer *)recognizer
{
    [self customControllerPopHandle:recognizer];
}

- (void)customControllerPopHandle:(UIPanGestureRecognizer *)recognizer
{
    if(self.navigationController.childViewControllers.count == 1)
    {
        return;
    }
    // _interactiveTransition就是代理方法2返回的交互对象，我们需要更新它的进度来控制POP动画的流程。（以手指在视图中的位置与屏幕宽度的比例作为进度）
    CGFloat process = [recognizer translationInView:self.view].x/self.view.bounds.size.width;
    process = MIN(1.0, MAX(0.0, process));
    
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        // 此时，创建一个UIPercentDrivenInteractiveTransition交互对象，来控制整个过程中动画的状态
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        [_interactiveTransition updateInteractiveTransition:process]; // 更新手势完成度
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded ||recognizer.state == UIGestureRecognizerStateCancelled)
    {
        // 手势结束时，若进度大于0.5就完成pop动画，否则取消
        if(process > 0.5)
        {
            [_interactiveTransition finishInteractiveTransition];
        }
        else
        {
            [_interactiveTransition cancelInteractiveTransition];
        }
        
        _interactiveTransition = nil;
    }
}

// 代理方法1：
// 返回一个实现了UIViewControllerAnimatedTransitioning协议的对象    ，即完成转场动画的对象
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPop) // 若operation是pop，就返回我们自定义的转场动画对象
    {
        return [[POPAnimation alloc] init];
    }
    
    return nil;
}


// 代理方法2
// 返回一个实现了UIViewControllerInteractiveTransitioning协议的对象，即完成动画交互（动画进度）的对象
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if([animationController isKindOfClass:[POPAnimation class]])
    {
        return _interactiveTransition;
    }
    return nil;
}

@end
