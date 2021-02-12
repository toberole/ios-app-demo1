#import "TestScrollViewViewController.h"

@interface TestScrollViewViewController ()

@property(nonatomic,strong)UIScrollView*scrollView;

/* 配合ScrollView 锚点View 小技巧 */
@property(nonatomic,strong)UIView*anchor_view;

@end

@implementation TestScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Test4ViewController#viewDidLoad ......");
    
    self.title = @"TestScrollViewViewController";
    
    self.scrollView = [self.view viewWithTag:1];
    
    // 小技巧
    self.anchor_view = [self.scrollView viewWithTag:2];
    // CGRectGetMaxY是获取y坐标值+控件高度的值
    CGFloat maxY = CGRectGetMaxY(self.anchor_view.frame);
    [self.scrollView setContentSize:CGSizeMake(0, maxY)];
}

@end
