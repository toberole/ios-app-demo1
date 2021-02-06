#import "TestScrollViewViewController.h"

@interface TestScrollViewViewController ()

@property(nonatomic,strong)UIScrollView*scrollView;

@property(nonatomic,strong)UIView*anchor_view/* 小技巧 */;

@end

@implementation TestScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Test4ViewController#viewDidLoad ......");
    self.scrollView = [self.view viewWithTag:1];
    
    // 小技巧
    self.anchor_view = [self.scrollView viewWithTag:2];
    // CGRectGetMaxY是获取y坐标值+控件高度的值
    CGFloat maxY = CGRectGetMaxY(self.anchor_view.frame);
    [self.scrollView setContentSize:CGSizeMake(0, maxY)];
}

@end
