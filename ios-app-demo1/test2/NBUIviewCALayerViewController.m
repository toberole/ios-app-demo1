#import "NBUIviewCALayerViewController.h"

@interface NBUIviewCALayerViewController ()

@property (strong, nonatomic) IBOutlet UIButton *btn_test1;

@end

@implementation NBUIviewCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btn_test1_clicked:(UIButton *)sender {
    NSLog(@"btn_test1_clicked ......");
    
    // 添加 CALayer
    CALayer*layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay];
}

@end
